Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-284719-1524837546-2-5743357051030757340
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524837545; b=eAzT5N8vmioRTYaGptXbZVD7ro5E8IkGV9xJ1ZAIxj3LOIF1HK
    A1DBk0lP/HonWKlNDrai6E6Nng9BrKJ92p4mKTuExynnv/C6XFy9EhBInUSGP0Qa
    j5eK9ikAAWdKfVWoFAHIc3b98+i2JUmyrm9fecSsd5XKUYEEunt2b9PCjkZk5+lI
    YHKIaBhxKzyNq/Jwq5pbs0g+QzMdIwzmyf+7NGUApxyJ6cTPbc7dR8d9zfkBaFXj
    hYL6YW0Sq+zHS46kqAfOpFSRS6cbjxx8X1mi4ANjTyEAeu/gbToaRkqXEzKjSche
    /l7BOPYSysDe49nR+hCD8f+6slUy4VNViLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524837545; bh=DrJbZa0zjvj8Ad8+MAdJOgBQoKN6jS
    tCvYK0BE/gbvU=; b=YYyY6eaYFqzhmoOqppmHO6FoELgvnKXlS+sfZSGLo8MafY
    hRjmG1x8Qw3+IGP1AQiPOcw9vrxOshUVVsVuadQOEq2zdjC7Qr7ByRTT5wL6e0lI
    46dkujbI2IjW+GRQ8sWNNEQ+GS3rRvfCOZHgOF1xhI8vS+MuIu3aT3kQv2/gRgLp
    MtumeKl7IlzYhAITXETyqdaTD2E9hqAUEdWtyXXX6B4wDGFDgi10E4efnvon1fMY
    atduImrlbjNoFMG3zGWuWMh2iKSPq+VoTI9C6i1LRkFAdTWKscJQknZ4+WbM5gTV
    BecG8wmDNlxde4CporSUKY5UUO4Kw6tt9gEOeHgw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfLwLkmadzvVFO1oB2HeHeKve09pyS2AYQ3XeDT55eBgLObckBHkZZITR2+MR3PWxqD1fpk8I76I/VrC4jPa1z7Z2JQfetWUCp2MdACDkYkHpCMzWt3RV
    mNItWMSWaNV++GsujZKiMY+1IUYYZkrqP8+MQkk8qU6kmk/hvhIHm4W0FyR5Xw+JD5L6HF9s7esiAjss+eKoOXT6k8SiCbLEo9CUrBDP7DTl0bH1zWRyZ0CW
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=NTWU-WrgUAwH667mvEEA:9 a=Mughydx_LTZaVgBr:21 a=M_CQfGMQezH4gP-7:21
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932916AbeD0N6x (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 09:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932861AbeD0N6f (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 09:58:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D1A21890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+6e181fc95081c2cf9051@syzkaller.appspotmail.com,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 16/24] llc: hold llc_sap before release_sock()
Date: Fri, 27 Apr 2018 15:57:51 +0200
Message-Id: <20180427135632.245037935@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>


[ Upstream commit f7e43672683b097bb074a8fe7af9bc600a23f231 ]

syzbot reported we still access llc->sap in llc_backlog_rcv()
after it is freed in llc_sap_remove_socket():

Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1b9/0x294 lib/dump_stack.c:113
 print_address_description+0x6c/0x20b mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
 __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
 llc_conn_ac_send_sabme_cmd_p_set_x+0x3a8/0x460 net/llc/llc_c_ac.c:785
 llc_exec_conn_trans_actions net/llc/llc_conn.c:475 [inline]
 llc_conn_service net/llc/llc_conn.c:400 [inline]
 llc_conn_state_process+0x4e1/0x13a0 net/llc/llc_conn.c:75
 llc_backlog_rcv+0x195/0x1e0 net/llc/llc_conn.c:891
 sk_backlog_rcv include/net/sock.h:909 [inline]
 __release_sock+0x12f/0x3a0 net/core/sock.c:2335
 release_sock+0xa4/0x2b0 net/core/sock.c:2850
 llc_ui_release+0xc8/0x220 net/llc/af_llc.c:204

llc->sap is refcount'ed and llc_sap_remove_socket() is paired
with llc_sap_add_socket(). This can be amended by holding its refcount
before llc_sap_remove_socket() and releasing it after release_sock().

Reported-by: <syzbot+6e181fc95081c2cf9051@syzkaller.appspotmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/llc/af_llc.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -187,6 +187,7 @@ static int llc_ui_release(struct socket
 {
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc;
+	struct llc_sap *sap;
 
 	if (unlikely(sk == NULL))
 		goto out;
@@ -197,9 +198,15 @@ static int llc_ui_release(struct socket
 		llc->laddr.lsap, llc->daddr.lsap);
 	if (!llc_send_disc(sk))
 		llc_ui_wait_for_disc(sk, sk->sk_rcvtimeo);
+	sap = llc->sap;
+	/* Hold this for release_sock(), so that llc_backlog_rcv() could still
+	 * use it.
+	 */
+	llc_sap_hold(sap);
 	if (!sock_flag(sk, SOCK_ZAPPED))
 		llc_sap_remove_socket(llc->sap, sk);
 	release_sock(sk);
+	llc_sap_put(sap);
 	if (llc->dev)
 		dev_put(llc->dev);
 	sock_put(sk);
