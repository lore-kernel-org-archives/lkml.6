Return-Path: <b-liu@ti.com>
X-Google-Smtp-Source: AG47ELt+CYSEg/vSURIOmb1Pnk2R10G/fVv4ETvb2VEf0mcvODF02//58lueJDt6RSuhdwxDMFFi
ARC-Seal: i=1; a=rsa-sha256; t=1521154062; cv=none;
        d=google.com; s=arc-20160816;
        b=ZiQH0+JGYIeSLXvq6FHMW+Z/pUPX7Yhj/8fJjskfYMraEhPIUUUM7Mfbu7tRKtTXd7
         X74h76+164g97c6IA1qXSRGCMRZkC75BMoXIMbLqJj504Ct+PdcAJIZLAOqZdxajruEM
         MN0pZKujeoEGRlfftW/GokJGnz1AMcX52a8orDs/vZTMrldlbheXMZPd/kogZ4h64Lmv
         z/e0EdNGOaRF+WqB/SpmqelqV1L72jAGtDdMuUiKJr/2vlk/GRfOgQzskqy96/nK3xDR
         VJ3OD+2fdxrwxCpjAMa/4zPmAkM5Pfpj8LLuilrgkvUX4NEpP4rt2sF7SW4TrRJ6yUux
         JWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=RwjL6evKSaeP9YF4v1WH8bdGIIhp/9xockofUx1Jl7I=;
        b=YApg1Xqwe9qyHY/7FFOMi/1iFZwf8BsAPDbFyYg+DygCGHIHBKLi4h3xJRQRiQCKhF
         dhQBXgZeewXaJj6rWV1g1vc2nPUn8bOehOhip9IvEo12AQVPpIYhOknAKUXNdYWtEPYG
         YCPeNyZPCiWFD/yMP7nuI52ZdwX9r6bORBNOiQN2yFmYlWaFEOrDfPWE+lSNZBY5m2Mv
         Y1bQv1x6ZrUbY+czLP0Lgb9ajBhqrdwvCSAHZa9fHxNYrUveLn0KCAYc2xMnBUDwM1sT
         HGzhhn5zv8EK0LykiPP+ltkFZGTzTcF3cYVP3dgtzXunL57iKjjobD+8LSu7DJtdDum+
         G8UQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=IENwNHT3;
       spf=pass (google.com: domain of b-liu@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=b-liu@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=IENwNHT3;
       spf=pass (google.com: domain of b-liu@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=b-liu@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Date: Thu, 15 Mar 2018 17:47:27 -0500
From: Bin Liu <b-liu@ti.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Arnd Bergmann <arnd@arndb.de>,
        Linux-Next Mailing List
	<linux-next@vger.kernel.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Aaron Wu <aaron.wu@analog.com>
Subject: Re: linux-next: build failure after merge of the asm-generic tree
Message-ID: <20180315224727.GC73@LTA0271908.dhcp.ti.com>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Aaron Wu <aaron.wu@analog.com>
References: <20180316091355.2d2b7b04@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180316091355.2d2b7b04@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595043554282877699?=
X-GMAIL-MSGID: =?utf-8?q?1595045642309531352?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Fri, Mar 16, 2018 at 09:13:55AM +1100, Stephen Rothwell wrote:
> Hi Arnd,
> 
> After merging the asm-generic tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> drivers/usb/musb/musb_host.c: In function 'musb_rx_reinit':
> drivers/usb/musb/musb_host.c:577:10: error: 'struct musb' has no member named 'double_buffer_not_ok'
>   if (musb->double_buffer_not_ok)
>           ^~
> drivers/usb/musb/musb_host.c: In function 'musb_ep_program':
> drivers/usb/musb/musb_host.c:807:12: error: 'struct musb' has no member named 'double_buffer_not_ok'
>     if (musb->double_buffer_not_ok) {
>             ^~
> 
> Caused by commit
> 
>   8312c0cad792 ("usb: musb: remove blackfin port")

I don't have a clone of the asm-generic tree to check, but this patch
Arnd sent yesterday for review doesn't remove double_buffer_not_ok from
struct musb. Is it removed when Arnd you were revising it based on my
review comments? Anyway, it is better to remove it too since this flag
is Blackfin specific, but...

> 
> I have applied the following patch for today:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 16 Mar 2018 08:58:41 +1100
> Subject: [PATCH] usb: musb: more blackfin removal
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

...is it possible to combine this fixup patch with the original patch to
avoid bisect headache in the future?

Regards,
-Bin.
