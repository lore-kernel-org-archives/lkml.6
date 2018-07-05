Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78DFC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A9D24181
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JKqqERBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A9D24181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeGEJdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:33:45 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46664 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753134AbeGEJdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:33:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w659T1xH028036;
        Thu, 5 Jul 2018 09:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=K3WL8d64ZOyPEZQETySrlGGWu1UFPnlZMhLVE6EWR8g=;
 b=JKqqERBa3/SanjYE+1jouDZ6sKiqF1tUl+/aghOXAxA3S8S/R4BlgIfFajxbbU/FaGLz
 7gWWbym/0i/x0+/kI4YBXHM6sLuFI82UHz4eLyMM+rN/8zkRyMhLwvSFHTF8UTR792jd
 9gnnyrt6qz5evADhPTIkmVoCgDzeUZNM7smIiRsc5GpBbIQNzfhGgtMK2Gc2AeLakFxQ
 PgtirFvTiCcso8mcjGbEKjDN4NrOk8FTf6SjyeX/j7q/OZkUmBo3/DtSAQmklUR8dwxp
 dvzuFTsAb6/JhcGYeLOpmrQaE7wfd7gQhyYDaBv88exG96hSfa3Ur0HxYTLdr48Ap60I Jg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2k0dnjd4vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jul 2018 09:32:53 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w659WpLG024213
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Jul 2018 09:32:51 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w659Wn28023776;
        Thu, 5 Jul 2018 09:32:49 GMT
Received: from mwanda (/197.157.34.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Jul 2018 02:32:48 -0700
Date:   Thu, 5 Jul 2018 12:32:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     Pkshih <pkshih@realtek.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Tony Chuang <yhchuang@realtek.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Steven Ting <steventing@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Birming Chiu <birming@realtek.com>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "sgruszka@redhat.com" <sgruszka@redhat.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "frank@generalsoftwareinc.com" <frank@generalsoftwareinc.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "linux@endlessm.com" <linux@endlessm.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Subject: Re: [BUG] staging: r8822be: RTL8822be can't find any wireless AP
Message-ID: <20180705093230.byqbk6f5ornezmka@mwanda>
References: <CAPpJ_ed1oFQW_xmBtetP-ztoL7Z14T6akOSgKJ_8jxogdf3FWg@mail.gmail.com>
 <f3bf0687-76fb-9411-6fa2-e8ef312efb58@lwfinger.net>
 <20180704140933.3dk2ylbntltz6jqd@mwanda>
 <7e95bd6a-97bc-b030-26ce-83da66e5f279@lwfinger.net>
 <CAD8Lp44EG73XQ9omQhH6XiHfm2rMypmndSFyffnf_PVMueTvEA@mail.gmail.com>
 <1530776154.4156.12.camel@realtek.com>
 <CAPpJ_ecCzhxEu8gMBFRsCerpeu_Z8TR=Rw5BiFhzVYP6WK-wAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpJ_ecCzhxEu8gMBFRsCerpeu_Z8TR=Rw5BiFhzVYP6WK-wAw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8944 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807050113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 05:26:28PM +0800, Jian-Hong Pan wrote:
> 2018-07-05 15:36 GMT+08:00 Pkshih <pkshih@realtek.com>:
> > On Wed, 2018-07-04 at 10:33 -0500, Daniel Drake wrote:
> >> On Wed, Jul 4, 2018 at 10:13 AM, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> >> > We will have to agree to disagree.
> >> >
> >> > I have no idea what the vendors are doing that cause some motherboards to
> >> > need a different aspm value. What I do know is that we have had to live with
> >> > the idiocy of some vendors saving a few pennies by only including a single
> >> > antenna, rather than two, and then making a problem by miscoding the EFUSE
> >> > bit that indicates which connector is actually in use. As we have no means
> >> > that I know about to detect which boxes have the problem, a module parameter
> >> > was created, just as in this case.
> >> >
> >> > I agree that drivers should work "out of the box", but finite resources and
> >> > lack of vendor cooperation make this a goal that may not be attainable.
> >>
> >> As you touched on, the ideal situation is that Realtek solve the
> >> issue. Ping-Ke Shih is on CC and I am adding a few more contacts from
> >> the commit log. The context is that the r8822 driver fails on several
> >> platforms unless setting aspm=0 (the default is 1).
> >
> > It's hard to have all laptop or motherboards and all rtl8822be modules in my side,
> > so what I can do is to analyze the issue when user encountered.
> >
> >>
> >> https://gist.github.com/dsd/20c05f0c6d66ee2ef9bfbb17f93f18ba
> >> https://bugzilla.kernel.org/show_bug.cgi?id=199651
> >>
> >>
> >> If we don't get a timely fix from Realtek though, I think there is a
> >> key difference between the antenna selection headache and this one. In
> >> the antenna case, there isn't a good value that you can set that will
> >> work on all systems. If you change the default behaviour you will
> >> solve the issue for some users while simultanously introducing the
> >> problem on other systems that were previously fine.
> >>
> >> However in this case, it's highly likely that setting aspm=0 (off) by
> >> default would work for everyone. It has the disadvantage of using a
> >> bit more power, but especially with the indications that this issue
> >> affects a significant number of systems, I think that having the
> >> driver working out of the box everywhere is more important. The module
> >> parameter can be left in place so that unaffected users that want to
> >> save power can set aspm=1.
> >>
> >
> > I think this issue may be due to L1 latency, so below patch would be
> > helpful but not sure because I don't have the same laptop.
> > Is there anyone can help to test?
> 
> I do not know why I cannot apply this patch directly.  So, I apply
> each line manually.
> 
> However, here is a good news.  I tested this fix, and it works
> correctly on ASUS X530UN.  System can scan and get the access points
> list.  Finally, it also connects to the access point.
> Maybe, you can have a formal patch for this.
>

That's good news.  What does the "dmesg | grep r8822be" say now?

regards,
dan carpenter

