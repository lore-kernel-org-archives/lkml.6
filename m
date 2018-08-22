Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE2DC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E572150F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E572150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbeHVRDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:03:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:50161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbeHVRDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:03:34 -0400
Received: from homer.simpson.net ([185.146.51.41]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZOan-1fXEUx2OCL-00LEBt; Wed, 22
 Aug 2018 15:38:26 +0200
Message-ID: <1534945105.8087.8.camel@gmx.de>
Subject: Re: bisected - arm64 kvm unit test failures
From:   Mike Galbraith <efault@gmx.de>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Wed, 22 Aug 2018 15:38:25 +0200
In-Reply-To: <c96d252c-6ed7-320e-0d47-c4b78af20ce0@arm.com>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532768831.9882.71.camel@gmx.de> <1532847330.1618.8.camel@gmx.de>
         <1532864867.1618.32.camel@gmx.de> <1532967899.30205.62.camel@gmx.de>
         <1533061729.12487.26.camel@gmx.de>
         <c96d252c-6ed7-320e-0d47-c4b78af20ce0@arm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wq77VYjENDL+uq4bHnOp0h045nZPF59E/oYd252BwfY/9pzZdYj
 OkyeUEF1BPKl5uS2WAAg9pBpbjSGuwnyiyPaLfUhqoPYIpbFkx0gqKiR0MISvo/JQNXwt4i
 bnW8d3UdOYkq266LXJNx9jSW/bJtUvHnG0IyzJNiNJkznG0o0GLvNgTgDeUsjOo9ZwFDqt2
 PQ9Mb6yshrPkP7OciWPDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XIRNYv2CRHI=:REyuyAaGxD8S8tSAit1L4k
 JBJz1HtRIwb6iYEPnnIROY1cxyhid9ohal6voxe/xHL2hmubrDWfSsfZCL81V70qauA7/+FJu
 5HVjv+7HTtZsfcxnq1Oyns1OwvqMLaTETNcr3IQxGbCzNvkcYsOj8i1Z6vGYfbQhEUM5+DZIg
 TOtAmKdzoNBlWoihMUxBJ4kvceg2dj4UI7yOYGmCPxsRS1od6Qy0Wh5R+LnZGNWyggN55d1oI
 hjeUOHf4DsyYXCzg4ZEsceI9RJjemkMVaNwE9WTbzG709vXv0/2PnbTDCga1GT4hYh97x0xWB
 jVdknzDvRRMg5sle+aKNoUsZKmmg5IXEFHk6FXQ5WBQg4+2KBkRbSi7bNRfQM97T32gF8LNg+
 8g5JdO7eKnueZu1c6+125h8N/4EjEm8EjkOjtJI9BcS1SoyNSzn3E7KmbgXx3FWK1oY0ifrMF
 r/c6CSzMqjjXXvDd5t+qT9iretxkeyxVmAE65Z5yZdVsdaDGPoFCD0Z4oh92kHrtD6Ul27e/4
 DCCP+2WAceMntx3Xmo3T1zQc1tL8aEQrWxfCOqMln4I3jX47VZGKSsTCRc09neVkvQYEj3Spl
 Spl/G1qsCnh5xuF9pT1bOUnqh4m6uZhT9rRLvSyd2Qspp11/rfv7f9eqTw4cZMz8IgWr1pJz0
 +d35WdFivk87vFq7TIqTNXYwV8UYM9l5amHkmKVPH1XUakYr/lIYI0CvKRehiZ6U8A+nyIi8s
 jpHNP/7oxktbdiZtDylIZOjSTVKg+00BlNV73Fu8T/Har1QKLBKGKfXHX9er6f955BX2ykY70
 QVUKHE0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-21 at 16:34 +0100, Marc Zyngier wrote:
> Could you give that patchlet[1] a go? It solves a similar issue for me
> on a different platform.
> 
> [1] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-August/032469.html

Yup, all better.

	-Mike
