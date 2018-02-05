Return-Path: <SRS0=oIUV=E7=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AH8x227HSfJ5U/iPqSyYWL1D3XLRKSUtkbjlRP5ezI9e08b7XxHH1pcsO++6rFpDtr/1pGlwSKjj
ARC-Seal: i=1; a=rsa-sha256; t=1517849838; cv=none;
        d=google.com; s=arc-20160816;
        b=g/LhBk2mqTn6jIp+2l3HZqR4uvbBNqZP7Qy5RPbbiYXD63KOcuRZjA6RFexpCHTKZu
         k2DbfKzbbQ6pjrzBiPuNlys09IfLaGskvU5WyzT/8/mRyIwSJxZ5ozDDXwLEJY2Gco1x
         GtNlCxrAD+westxIVxgF0cVddR4XOAR51zmOlQYDgwwkq8HM+NztEIjvu4yQriYdZpSK
         HzF4Xv6M6gWRMVH+N8ABBJfkVahO6ckvP9x/oJr2rnioA/NV2W/zS3otvTXnZ6idiRKY
         x367MjuZdri1bH/fHEhT2nP/JWbuwxm0pRGAjAq74e3F87BvrpJSJw9g9iBx0/jp/POS
         dv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=7FjPPBwH5syGuWE4zjoHHMhyhM8zFJN1O/h992i4XxQ=;
        b=cv7lOPnV5YbBfAyr0sZyV37elu+pLx1MidAxHmhTOybjYTDw7QGc7OaZBIJXK1hfyl
         +/86R7gwpBhpbeJhYFzL0Wkf4YCsslT6pYjC0aVBGiM1gq0h76oqoOZngev37nOwQ0kC
         piTw42yqbq1OSv1fLGMO70ur7rCwV4orzaRNQx1m4tS771cmabOBoz7So84gAExNNOH+
         Q9/8JFvDPUCTDPRUBztVDvgNtNlK5D4dYgFZa3ushfPV8q/XqHdV/Bg7kNk/jOOSVGpB
         A2k2jTm3Oh+AkBwpyuz8zmyOSrWPCcpHTY8yQdD7J3JS41qWiuZyDVnLlGIs8ljyqBzR
         Fpwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=oiuv=e7=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=oIUV=E7=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=oiuv=e7=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=oIUV=E7=goodmis.org=rostedt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BF72172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 5 Feb 2018 11:57:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper
 <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
 sboyd@codeaurora.org, rnayak@codeaurora.org, asathyak@codeaurora.org, Greg
 KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFC v2 3/3] drivers: irqchip: pdc: log PDC info in
 FTRACE
Message-ID: <20180205115716.61e0b881@gandalf.local.home>
In-Reply-To: <20180205151846.GA13552@codeaurora.org>
References: <20180202142200.6229-1-ilina@codeaurora.org>
	<20180202142200.6229-4-ilina@codeaurora.org>
	<alpine.DEB.2.21.1802021652100.1472@nanos.tec.linutronix.de>
	<20180202230232.GB15464@codeaurora.org>
	<20180205151846.GA13552@codeaurora.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591305373445487149?=
X-GMAIL-MSGID: =?utf-8?q?1591580912870337076?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 5 Feb 2018 15:18:46 +0000
Lina Iyer <ilina@codeaurora.org> wrote:

> >Some product configurations disable debugfs. I will ask around if this
> >can be dropped.
> >  
> Memory dumps after a crash have support for FTRACE and it helps greatly
> on production issues. Hence the preference for FTRACE support.

Note, ftrace no longer depends on debugfs. It has its own tracefs file
system:

 # mount -t tracefs nodev /sys/kernel/tracing

-- Steve
