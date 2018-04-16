Return-Path: <BATV+720190a116820ebb5dc4+5349+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx4+wcv8QVOK1ox2l0lbosXwmRBL4xOS20oFA45+MCz+cBWhk1PiP2FMOVBry6hdClHaHIvBf
ARC-Seal: i=1; a=rsa-sha256; t=1523882016; cv=none;
        d=google.com; s=arc-20160816;
        b=PM6KyInUIx7eVsveb0YFVBrFKzXCuPF8dfU6Pz5bfZf+gfta80KBmir7QYEXVnUo4L
         hIORTG+HFQ4rO+bBnTtXU/tAdkLeu/oM8c3ZO8yK5rMQ6zxy3eC91WDAiRua3P6uzYZ2
         Bjw/2GKyRGVe75HPThqvOGPT4Xd87KL6BYd2/flwOTKgQOhqic5nzSQKYHV468rNKRh0
         IqIsNzPrJfG83tza+TtUHPtFd/DD73DX0tvNcZGx3+7a2S3aWlpXYuuHlUYIJujPGStO
         cJ8ymUAQPQj1ArIKlhGlhpv7oAYSrIPQ5/DltS3q0oruGuuheKTcT1H6cIvgLMQkFw/p
         J84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ahpqK9gXIYeiOs5yhpdS4/UQYmuQxRr9g7o8SOn0MYM=;
        b=ccBnGwNNw43rSmoGPU0vIE8tVqSN3VMPGQt/V2iQG4akEYsPskJM6Xafvu+sGKSoE6
         5Ft1OmTxpgftcMSFABtmt8pVXILwxKjNiN3wpVQChQnaBmauYQ3NR3ENBvL/obb2mcTH
         Zu4F9Fbhr4WHgJuE4fHB+pS4Qo52HX8Uk9PPTixJcBTwdTQ4vIBJS1CxsTHSgVbLYTCF
         /2BPZ5tcW4Odajirie8ySinzjjz3TwXF8HlXwCt8lAvQNxsBVTgWoTe68YBJcIeoaY3j
         5kEa4T1ZRj3smElBb/LNHDEKwLQWHalfMqk7VQJnbHGaP+Nlio1NaVempPGa56ihHMwn
         J0Gg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=VwzfrHFy;
       spf=pass (google.com: best guess record for domain of batv+720190a116820ebb5dc4+5349+infradead.org+hch@bombadil.srs.infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=BATV+720190a116820ebb5dc4+5349+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=VwzfrHFy;
       spf=pass (google.com: best guess record for domain of batv+720190a116820ebb5dc4+5349+infradead.org+hch@bombadil.srs.infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=BATV+720190a116820ebb5dc4+5349+infradead.org+hch@bombadil.srs.infradead.org
Date: Mon, 16 Apr 2018 05:33:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Wang <davidwang@zhaoxin.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
	gregkh@linuxfoundation.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, brucechang@via-alliance.com,
	cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com,
	benjaminpan@viatech.com, lukelin@viacpu.com, timguo@zhaoxin.com
Subject: Re: [PATCH] x86/dma-mapping: override via_no_dac for new VIA PCI
 bridges
Message-ID: <20180416123330.GA6848@infradead.org>
References: <1523870816-6214-1-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523870816-6214-1-git-send-email-davidwang@zhaoxin.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597894379144798679?=
X-GMAIL-MSGID: =?utf-8?q?1597906109391238946?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 05:26:56PM +0800, David Wang wrote:
> PCI bridges integrated in new VIA chipset/SoC have no DAC issue.
> Enable DAC for the platforms with these chipset/SoC can improve DMA performance about
> 20% when DRAM size > 4GB.
> 

So we get an exception to an exception?  Is there any way to figure
out the PCI IDs actually affected?
