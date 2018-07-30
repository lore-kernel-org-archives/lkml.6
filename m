Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DDBC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0CC20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1uJSeoHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0CC20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeG3Iei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 04:34:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48844 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeG3Iei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 04:34:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6U6wtG5058848;
        Mon, 30 Jul 2018 07:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=4hT5WcDVsx81HVG1ZtETjglA+/jYIWqzUT3+/P2AeqI=;
 b=1uJSeoHXV+yNnypiR6opKsP+fTmyRUW94hXPQNbfbQY63kTRghdLQHrBzetIzxi+x0GG
 R6hkaIZBLu3G3TmYkRjR+j+yCWhTijUOW708+DHzZe7RYNBc8G3vnuK41oIX80W+Rnfg
 PY8l+SiLse9DwN3V66b/pCjHSg5Q/AkHhjgmbQyogAwpzCbXjyh28GqvpN75RCPZTccC
 b0v6XlzGPKfjWApp1tOXWiV6Bf6SDZROuBp5QS9TjXVy2GXM9k8FVGzTNuL6fdXXRTkj
 cxvcXI+V3D0WBnO3/FBiTU0f8sBnBeeVQ+nmiygcVBSIxa1omKhQjVzpPU0ZpCVppGp8 zg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2kgfwsu5h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jul 2018 07:00:57 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6U70vor012281
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jul 2018 07:00:57 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6U70ujf010327;
        Mon, 30 Jul 2018 07:00:56 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 00:00:55 -0700
Date:   Mon, 30 Jul 2018 10:00:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Zhongze Hu <frankhu@chromium.org>,
        John Joseph <jnjoseph@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Simon Que <sque@chromium.org>,
        Rob Springer <rspringer@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH 17/32] staging: gasket: annotate ioctl arg with __user
Message-ID: <20180730070047.7ornpqv66i5mi42g@mwanda>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
 <20180717205712.29495-18-toddpoynor@gmail.com>
 <20180719093743.GC14301@kroah.com>
 <CAO3upoYdSkDqyLtD8cQh4kws5gdOcAEPSUHnsru23Uo=3c-uMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO3upoYdSkDqyLtD8cQh4kws5gdOcAEPSUHnsru23Uo=3c-uMQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8969 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=836
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807300080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 07:44:53PM -0700, Todd Poynor wrote:
> >> @@ -549,7 +549,7 @@ struct gasket_driver_desc {
> >>        * return -EINVAL. Should return an error status (either -EINVAL or
> >>        * the error result of the ioctl being handled).
> >>        */
> >> -     long (*ioctl_handler_cb)(struct file *filp, uint cmd, ulong arg);
> >> +     long (*ioctl_handler_cb)(struct file *filp, uint cmd, void __user *arg);
> >
> > Why are you not using the typedef above?
> 
> There's a typedef for the permissions check callback, but not for the
> handler callback.  It's a bit confusing, so I tried adding a typedef
> for the handler, but now checkpatch is spanking me for adding new
> typedefs -- maybe I should drop the existing typedef?
> 

Someone should update checkpatch to not complain about function typedefs
because those are obviously OK.  It wouldn't have even occured to me
that people were avoiding them because of checkpatch...

regards,
dan carpenter

