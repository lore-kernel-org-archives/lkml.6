Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-196919-1522173856-2-4340299269742642929
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522173850; b=UoSXxH9EB08x5AwLxYG3PXewOxCfUWTTwHBncyLBfQPUKST
    Wc7QHb4jBhRcJn9Y89tYokAoxRYXzxrD8gfG61sjd93pa4hHVVVpO/NwzSJu00Bo
    UCu6DZX64t2/kvayB9Vguh7n2YtaFij4R3X2Bid93RX3A2NRca1q08uvyDMyVdvQ
    T9Nm4hRHIjCRiE4d5QGjlmbnHLO/6gHmSHIqVzbbUaUoHEdk+kJezN6xl88jO14U
    V122CXiaah+Paersn6GCwMps7hwyWXGij+po7R2NOcS1Dx0GmFBu1UJPOhcwpKBS
    TSgT6etqWc3XtMNSdhK6n+JZQVY2KVqPWZ2XSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522173850; bh=NVRbf7KP6juD3Tn4b8Yn+b5AhB
    QIlf6wxHfWIc6yNFA=; b=knJUUoB8MkqpS67DsiNShtdjywDpxlxiswcaVakMVl
    w66RBjLKdEv/Rrqnefjn1pirrMsq0FFC+ttHSuPaH1Dzweoroyu021jn7ZtMuhfu
    ymC8frMf70gRlsvSgGSVyNQIQH7jrlCV3u5kvideX2pV7Rwj8gmOXMGjXMHrhRlH
    9PpCk70+27ord3ic9+DXpMcojtQ6usZ276DVL7HIQjQDygLQq0NJQ3UJBsMACowX
    kZOUigmvJCviYuYZp7QRHZqIsw9CH3DMmL13gMfZOEDP8rzfoNzorGORf/GNS9Us
    zc6ArBgl6gJxHo+T6IYJNXCoouXi+dw3gSvihHGLl2XQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfOKiiWtLBVGuuzPKNUWHBzglbVV887e4fsNNjNJggS58zly8RO+T9XeKzwyQUynkRjlUdkjyC6YP7WSr46MATT86NaandM47H4NuWTiKhYRVOFAvq/6h
    ZR0mwH4i192/AVUes7t1WLKJGJzJnaDQ3ZEy0M9Iyu9LS08FoHW2hfif0Go9H6AtkxYYlU5PbLPe/U96/Dm0FNUlxe0DL6KnYDEQzPvXegbowsUawkkbxAVq
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=Z4Rwk6OoAAAA:8 a=69EAbJreAAAA:8 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8
    a=bnRgyvX07LPeTolkEFsA:9 a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750937AbeC0SDv (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 14:03:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41490 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752788AbeC0Q3u (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Holderness <j4_james@hotmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 34/43] tty: vt: fix up tabstops properly
Date: Tue, 27 Mar 2018 18:27:38 +0200
Message-Id: <20180327162718.327885560@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit f1869a890cdedb92a3fab969db5d0fd982850273 upstream.

Tabs on a console with long lines do not wrap properly, so correctly
account for the line length when computing the tab placement location.

Reported-by: James Holderness <j4_james@hotmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/vt.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1725,7 +1725,7 @@ static void reset_terminal(struct vc_dat
 	default_attr(vc);
 	update_attr(vc);
 
-	vc->vc_tab_stop[0]	= 0x01010100;
+	vc->vc_tab_stop[0]	=
 	vc->vc_tab_stop[1]	=
 	vc->vc_tab_stop[2]	=
 	vc->vc_tab_stop[3]	=
@@ -1769,7 +1769,7 @@ static void do_con_trol(struct tty_struc
 		vc->vc_pos -= (vc->vc_x << 1);
 		while (vc->vc_x < vc->vc_cols - 1) {
 			vc->vc_x++;
-			if (vc->vc_tab_stop[vc->vc_x >> 5] & (1 << (vc->vc_x & 31)))
+			if (vc->vc_tab_stop[7 & (vc->vc_x >> 5)] & (1 << (vc->vc_x & 31)))
 				break;
 		}
 		vc->vc_pos += (vc->vc_x << 1);
@@ -1829,7 +1829,7 @@ static void do_con_trol(struct tty_struc
 			lf(vc);
 			return;
 		case 'H':
-			vc->vc_tab_stop[vc->vc_x >> 5] |= (1 << (vc->vc_x & 31));
+			vc->vc_tab_stop[7 & (vc->vc_x >> 5)] |= (1 << (vc->vc_x & 31));
 			return;
 		case 'Z':
 			respond_ID(tty);
@@ -2022,7 +2022,7 @@ static void do_con_trol(struct tty_struc
 			return;
 		case 'g':
 			if (!vc->vc_par[0])
-				vc->vc_tab_stop[vc->vc_x >> 5] &= ~(1 << (vc->vc_x & 31));
+				vc->vc_tab_stop[7 & (vc->vc_x >> 5)] &= ~(1 << (vc->vc_x & 31));
 			else if (vc->vc_par[0] == 3) {
 				vc->vc_tab_stop[0] =
 					vc->vc_tab_stop[1] =
