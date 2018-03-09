Return-Path: <kernel-hardening-return-12312-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvpp4dxcnFJFOyhIp0Y4O53ITMguOGA2vGxfCvUbYgba2sypIuSu+vvADfxYT7QYUdxfiLS
ARC-Seal: i=1; a=rsa-sha256; t=1520594899; cv=none;
        d=google.com; s=arc-20160816;
        b=jEFPpJJwtI5eeNOf1rMjrycHNv6SB9aSthmw/2jgtyuVFbj+Kkb4qz2m2U++Mny54r
         BbI1VYhx2FZsLlWVezZ8nsyBKq7mOYL7Eg/AynxCuzEnZ38LegdydQz+LjtYeFv4Hv31
         zHAQC5OXCwXrBF8nXXekeFNgsizO45dqOe2Dpi9DYw9USNcFpins0N6gMeq5bXs9Xq4Q
         06nS0uMuSK6Ox+ci7FZ0b7/F1UdEC+BR2Gjg0lrLaMPmqEyonAYD4olDYrot3Wg1OJqV
         EFebhicAc8gwO9vviPJLgBrBldbYnJJfwwwyR2A3RJgENCkaXF2BBN86eveV61LnYT8E
         w7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=+/wgFa+rxFl12obDO9BTxALySt7f4HvcLO9KeAmh+tU=;
        b=axE0Lvg5l3xllpnBoqcHmVdxNsnKD7Zbag1k8P0EA31tx796kchcp+ovTtk/1zC4wG
         C7Rl1D8N8FDsk7ILsHAFVDSwrAwk4V2umdnnLDNiRT13AiTHPD9ODkOTMrvhcXpvRCU+
         oudSdio4NdWn5OUiL0jV+vSaaavsCnRToBPn9WYYfbJT/elluNGIOxdY7G2tnq61Vv4B
         7UWbCLD0LRyHizj/u9uZ8OhO5avXptioRghZsaBc+OOJCQPchL4szuOhbFV13eksLWN8
         B1lwbGWwSZHoe2xxt6qfAN/Gn9UjCiIBIkugiGK3kEk7+gyfnHKg3FmuC+QtkHLt6TVB
         l+NQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PBJOwcDl;
       spf=pass (google.com: domain of kernel-hardening-return-12312-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12312-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PBJOwcDl;
       spf=pass (google.com: domain of kernel-hardening-return-12312-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12312-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180309105940.22hd2uy2mv7wahzb@imgtec.com>
References: <20180308173949.GA19305@embeddedgus> <20180309105940.22hd2uy2mv7wahzb@imgtec.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Fri, 9 Mar 2018 11:02:24 +0000
Message-ID: <CACvgo5278SmXfV0jfrMu=Ba6gf7rRXzNduNX+D270fGUFQcZdQ@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: via: remove VLA usage
To: Eric Engestrom <eric.engestrom@imgtec.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev <linux-fbdev@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	ML dri-devel <dri-devel@lists.freedesktop.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594392120539391557?=
X-GMAIL-MSGID: =?utf-8?q?1594459317135034294?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 9 March 2018 at 10:59, Eric Engestrom <eric.engestrom@imgtec.com> wrote:
> On Thursday, 2018-03-08 11:39:49 -0600, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wvla, remove VLA usage.
>>
>> Also, fixed as part of the directive to remove all VLAs from
>> the kernel: https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>
> Sorry for my reply on v1, I missed that Emil already replied to another
> post of the same patch (side note on that, making use of `-vX` and
> `--in-reply-to` helps track the evolution of patches)
>
> This looks good to me:
> Reviewed-by: Eric Engestrom <eric.engestrom@imgtec.com>
>
Same here
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil
