Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F78ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7DF20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G6q8mcFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7DF20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388164AbeGTR7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:59:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52430 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387989AbeGTR7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:59:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6KHANIi021673;
        Fri, 20 Jul 2018 17:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=VW3eyL7VOjae76jaBzJHeNtb2cwVmVP3u57kQ4jgfJg=;
 b=G6q8mcFlqnxsB2ylKcDUYV0PCiGSTN2J036dHfArO2+kjnZVvvG9JEAniV+n2J0dZpdb
 CREV6AlTHNMohdQtdoPx1itQIhbbDGBaVYdZjAl6M2Ok7ZSvrTXcOOwl7TBbsHlsa+2H
 XQdsQXGLl30cSIZbaX/JW446/GdKnejk2nJr3ZKNOyv8YhAnOvhgiASAanV/MrKwBD2+
 FTIxJgPj5zCFaJx88ilEJfKGj1xlu6l9u5OSLF5ZspV6mS8xLl0Y/Vrl0awDS9CO28Y6
 aWrzDm1w7zic0ReSrWTkJmvINJ1v13Mgx1lDXAzCmZIjN0ZKlF0I4fV/d6zzcVm/kcuO yQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2k9yjxc4h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jul 2018 17:10:23 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6KHAMOi020686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jul 2018 17:10:22 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6KHALVI021165;
        Fri, 20 Jul 2018 17:10:22 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Jul 2018 10:10:21 -0700
Date:   Fri, 20 Jul 2018 10:10:20 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Markus Heiser <markus.heiser@darmarit.de>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Sphinx version dependencies?
Message-ID: <20180720171020.GI4800@magnolia>
References: <20180719181556.GA21435@thunk.org>
 <20180719190400.GB4800@magnolia>
 <44d73cd9926f58976a1269ff3cd3afb845ec84fa.camel@darmarit.de>
 <20180720131206.GM30706@thunk.org>
 <d064f468ab9fc60a02242331e0dddc185d6556ba.camel@darmarit.de>
 <20180720145235.GA27862@thunk.org>
 <cd31ba58ac24851698e06628ceebce4648345ff6.camel@darmarit.de>
 <20180720164421.GG4800@magnolia>
 <93aa59853a491a5ba3d5c3bcc0c991a1b815a67d.camel@darmarit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93aa59853a491a5ba3d5c3bcc0c991a1b815a67d.camel@darmarit.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8960 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807200190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 06:58:57PM +0200, Markus Heiser wrote:
> Am Freitag, den 20.07.2018, 09:44 -0700 schrieb Darrick J. Wong:
> > and now I'm just confused since 16.04 has the same version of docutils
> > and an older sphinx and runs fine; but 18.04 has newer docutils and
> > newer sphinx and runs fine.
> 
> Same here .. I'am completely confused by distros etc. .. I will never be able to
> control that. Thats why I recommend the virtualenv workflow (as I wrote Christoph):

Well yes, but it's the virtualenv workflow that produced build errors
for Ted; that's what would seem to need fixing?

--D

> $ sudo apt install python3-virtualenv
> 
> To setup up a environment for building htmldocs:
> 
> $ python3 -m virtualenv py3env
> $ ./py3env/bin/pip install -r ./Documentation/sphinx/requirements.txt
> 
> To build htmldocs with:
> 
>  $ SPHINXBUILD=./py3env/bin/sphinx-build make htmldocs
> 
> If the env is no longer needed:
> 
>  $ rm -r py3env
> 
> Am Freitag, den 20.07.2018, 09:44 -0700 schrieb Darrick J. Wong:
> > Yes.  This makes writing broadly portable markup difficult -- originally
> > I did not take the '=' all the way to the right edge of the table
> > because I saw that last example in the above document and assumed that
> > it wasn't necessary to extend the '=' all the way to the right edge.
> > Neither Ubuntu system choked on it, so is this a bug in upstream?  Some
> > strange patch added by the distro?  Something that ended up in the
> > python wheel?  Or a bug in the spec?
> 
> I guess in the version history of docutils ;) .. use workflow above to escape
> from distro chaos. Even missing '=' will be OK.
> 
> -- Markus --
