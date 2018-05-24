Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159427-2-15423335152324306648
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159426; b=iM3tx2Rz9V0UhlQCbNzsF1vRWajLvKpYoQktZiFlaR2q2+23HP
    eehDVSPf0iXSRJw3ymJyS+iVFgfVpwl8Lu82SMukevTvq4oLeoa0twAbFQIOWFWN
    FrTC9hAuM9hxpcMoaUAHwWEruCUr2gdb9kOuFcrFrbX98xz3o+t9Dq0Iv4NSvXD2
    LDmg1YKLHWpAnwhPaqGq0K71KpXH5LhxFqXORyXjIpq1DdEWS3OJD0VTZi26z6Zz
    /uObken6VXlmw4pg3pTtqRl+ze7vqbI1lwBtQ4JrXqksZViMbaINIPzSzk1whzXt
    peOxvxWf9ri4LvlhHkecms1S1DwRT52C/3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159426; bh=vWZpe/psZw62xljLviW4k2Qk1HEBlT
    IyYGjWanMVcrc=; b=BtkszYwTdp2ZBRIaS3NRz9Hjp4pxnm4Fbjob+oaC4ttZvV
    eWE/TdSho7Gp++8HkTrp95JSNYwiZxmps3XkdkKjWUuHVoiQkgWrlU7c/HTHl0sz
    Nsmgids+xxggA05wJB9BfH+rA4cy3PiTUyKS7c+cu5YChxTkbrRCIePmjqUJCkQT
    /8o6fR5pMOUS6Q3sSwk1zzn5pbJApXOYhgG5RMfz3Lgoh7pRc3zjMOHnEolIPS7G
    6M1u41jMOkNf1LjD0PDfoQ2oueJxflj8FkOPXZiLtCihoj+dzn9+vzDZtIl/cqc4
    d0uoLKg/JUf1nFSVAJbpdZACNxPdB9ElQ6MDzvBA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=HCqFOJUz x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=HCqFOJUz x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNwxBIM0V4nCoxlFPLkGjyDMj/HEAWczLVXVairTD1T7jrHqb9UzSAPxqAsaj/d+f8OrraTktxT1Mxmx93APBqjXVV1xifaWEbg93jaMgIspVJZjtWVW
    /DcLfdKDZbKijNfYxe/rUgNgsMKTmU/0XpaJzD1QJYOGXej3zdhCUBiZweGkbThGU7KJykMA/fCLisEyi9BnTqRD1gmBuEbF3Q9eYHBCi8Um/adFoX3fbqiD
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=xq3W2uTSAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=VwoBRhHq2TX8QzjGAlQA:9 a=_LlKgRvWRC-LHkIO:21 a=DGC3x8MQNSjrJErm:21
    a=QEXdDO2ut3YA:10 a=P5L7wpMTXyg1GfFA3Gwx:22 a=NGXS0kB0m_rannUenejW:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030394AbeEXK4u (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:56:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967722AbeEXJ4Y (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:56:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brad Love <brad@nextdimension.cc>,
        Michael Ira Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 082/165] media: em28xx: USB bulk packet size fix
Date: Thu, 24 May 2018 11:38:08 +0200
Message-Id: <20180524093625.335962903@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit c7c7e8d7803406daa21e96d00c357de8b77b6764 ]

Hauppauge em28xx bulk devices exhibit continuity errors and corrupted
packets, when run in VMWare virtual machines. Unknown if other
manufacturers bulk models exhibit the same issue. KVM/Qemu is unaffected.

According to documentation the maximum packet multiplier for em28xx in bulk
transfer mode is 256 * 188 bytes. This changes the size of bulk transfers
to maximum supported value and have a bonus beneficial alignment.

Before:

After:

This sets up USB to expect just as many bytes as the em28xx is set to emit.

Successful usage under load afterwards natively and in both VMWare
and KVM/Qemu virtual machines.

Signed-off-by: Brad Love <brad@nextdimension.cc>
Reviewed-by: Michael Ira Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/em28xx/em28xx.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/em28xx/em28xx.h
+++ b/drivers/media/usb/em28xx/em28xx.h
@@ -191,7 +191,7 @@
    USB 2.0 spec says bulk packet size is always 512 bytes
  */
 #define EM28XX_BULK_PACKET_MULTIPLIER 384
-#define EM28XX_DVB_BULK_PACKET_MULTIPLIER 384
+#define EM28XX_DVB_BULK_PACKET_MULTIPLIER 94
 
 #define EM28XX_INTERLACED_DEFAULT 1
 
