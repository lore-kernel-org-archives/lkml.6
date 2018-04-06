Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523022393-2-1042261528758542997
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523022392; b=Rx7aLRCFCERdsnpwp4Z0jLAw+ycZ8Pjp5cz+mK7PkOz/chXIQA
    OtDP601dB1J9wJf0tATJaW6hOydbOAMlMNJwbu1VAkVp6tU1ZZtgo60ZkneVyCIy
    3fOazXFt/8BMw5nciydBg4beZgFKexDzU+YtpCLAFxXYVpAA7TaRjYqR+Xmaf4TH
    aqlTbFu1nk1B8Ww6omHISsrP8YNOQf7yKpvfBj4oWc3Hi8tIirQbZxp6q7MJXGkn
    GAgZ3HRvMIFWdzd+A4Knzmlc80+7A0RMwQZfZwHT1u+RadBSGSjl0r+o2n8sBNrM
    6mLowLSvsPtgSMyGhMmsnNc3SYCBupptn/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523022392; bh=p7GEUVNemgADW2PR8896eh3cqeEEeZ
    E3cq47+HHY6P4=; b=n3amqv/96Y58lbaGVs/pdAMIN3CfyWV32FuinwOA2IaJap
    Tdx1/8MYl5L4x4APlS6T00la8lp+8mslY7vsgX/GH1cPrI9WiWpaMOVOGhNi8+JR
    8quNRv5Om4hJFSV42bRWEB4/gH5a4hqggWZ4iBWhPAiyM7aITnvBWOMPqyr620gq
    i2RLUD4oRdBu4sXJ0xaRDtnlhUfIXZesxqsB1fSgJQ2kgoAZwLHN+9PA+JR7ejPB
    yoFg44Ui9pQbaEcvWqz94LREq0n46251vNzf1A+8rmBchIeWh3In7QG9chJLGqyj
    YCasWWS7HypQXs0nMvmaILFah0YJxIgz7COclMOg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEOkOVm1x/Phyp9q1+FSkoOgsYprQ9iKfQLZcyMvZIbKgRhgxM5E+dddp4GQavwxFbOQcF7Dx1c5qcglZgT2tsmkkJlhkD/1UxfJzP/IVmL9f1Tz0/kk
    FwHW+YNpmftj8/dbZiMCHNy5oI8z3wV7wprmQNTXcWjoYt0udKamT7oJNvcB+7ikbzgSVsvVY6YSjUv3LAgAbFgt084dXzsthcaKjcwYfdTnWJm6Bh4eUsQ0
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=AUd_NHdVAAAA:8 a=vQBBkBfzAAAA:8
    a=ag1SF4gXAAAA:8 a=XH12Hu3fgITBCdxw0yMA:9 a=QEXdDO2ut3YA:10
    a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22 a=NGXS0kB0m_rannUenejW:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933084AbeDFNpg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:45:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38134 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933082AbeDFNpe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:45:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Yavuz, Tuba" <tuba@ece.ufl.edu>,
        Oliver Neukum <oneukum@suse.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.16 08/31] media: usbtv: prevent double free in error case
Date: Fri,  6 Apr 2018 15:24:33 +0200
Message-Id: <20180406084342.178292706@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 50e7044535537b2a54c7ab798cd34c7f6d900bd2 upstream.

Quoting the original report:

It looks like there is a double-free vulnerability in Linux usbtv driver
on an error path of usbtv_probe function. When audio registration fails,
usbtv_video_free function ends up freeing usbtv data structure, which
gets freed the second time under usbtv_video_fail label.

usbtv_audio_fail:

        usbtv_video_free(usbtv); =>

           v4l2_device_put(&usbtv->v4l2_dev);

              => v4l2_device_put

                  => kref_put

                      => v4l2_device_release

  => usbtv_release (CALLBACK)

                             => kfree(usbtv) (1st time)

usbtv_video_fail:

        usb_set_intfdata(intf, NULL);

        usb_put_dev(usbtv->udev);

        kfree(usbtv); (2nd time)

So, as we have refcounting, use it

Reported-by: Yavuz, Tuba <tuba@ece.ufl.edu>
Signed-off-by: Oliver Neukum <oneukum@suse.com>
CC: stable@vger.kernel.org
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/usbtv/usbtv-core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/usb/usbtv/usbtv-core.c
+++ b/drivers/media/usb/usbtv/usbtv-core.c
@@ -112,6 +112,8 @@ static int usbtv_probe(struct usb_interf
 	return 0;
 
 usbtv_audio_fail:
+	/* we must not free at this point */
+	usb_get_dev(usbtv->udev);
 	usbtv_video_free(usbtv);
 
 usbtv_video_fail:
