Return-Path: <kernel-hardening-return-12428-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELubn6XKlOAozsLoa91FHNsDnR0vLA5mNXyBcyANTi9Dd5S8TySsIecyr8jXbFYgJbkDybu0
ARC-Seal: i=1; a=rsa-sha256; t=1520853266; cv=none;
        d=google.com; s=arc-20160816;
        b=n2wUfWyswhTcCFFvdf2hhZhI40vCPluUd0Rz0nlTG/O0w9n05uZkam39oXOIFol5Pz
         iRlycGAEqKeg7I2D9Sg7REXUm+/QpEVmsspIn5UH+oJDHDpWjWWg0T5VU6XNTFyrHNtr
         Cnhl3tFAglvk3sR/4r9ykNQ6EA0tz+mxKfitOeJJq5XqyvswXDvvIvipHJJ6FkhMH9Kl
         xqMyvGagVLUDC4DgllxUu4G01csrEEgnpzR2BsImu4t1hasi/2G5oOp2MfsQIRdWYy9D
         s600hg+/9/7jPvwKNb38gRR6dMoUqUpzVG+tcQ7OgayW3uJ8zaZ7v0eagGgSpu+gzc2Q
         vSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=GOIzl2cXD7CmYZ/YZ1boYAI6pKzySdTtRIBm2apZnmM=;
        b=PZP7hvqz8bHGfRp6zJBR/1RHnXR8eaW/EkhGFk1rXnFxsHf7fvOZoiBpEJYqcoa7tJ
         lezAIKLh97oQNA1wxZHw3H4Y+IkmPwf5J5h2zSJdDzj5sTq9BRJXZs2KQ1ltgnxtP6QO
         NgrsRpU4ZqRNvlf7dZ7NVjNi5EHnV4RZQR3rLCpI5ExNWiC8zHQgktKV0GJnKlE0Flpq
         rmosdZTKCwonWYNDZUXy6K484k784Y3mr04UmzKZ+T9/h/2z4Oed/XxW9pz2nsohnIOY
         BCNp4YKeieyPbFDdETR3MAnepoSe7sfXPRKZith8vT+knfu1DHkfurgfGdbmJnPonKau
         FVnw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12428-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12428-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12428-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12428-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4092178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
MIME-Version: 1.0
In-Reply-To: <543a0a74122172acae549329b35964f402da8b77.1520660422.git.gustavo@embeddedor.com>
References: <cover.1520660422.git.gustavo@embeddedor.com> <543a0a74122172acae549329b35964f402da8b77.1520660422.git.gustavo@embeddedor.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 12 Mar 2018 12:14:04 +0100
X-Gmail-Original-Message-ID: <CAJKOXPc3ELO9sX0Xp391D2_3uDHK91snzHDn6FmDrJ6dt3E_Zg@mail.gmail.com>
Message-ID: <CAJKOXPc3ELO9sX0Xp391D2_3uDHK91snzHDn6FmDrJ6dt3E_Zg@mail.gmail.com>
Subject: Re: [PATCH 2/2] rtc: s5m: Remove VLA usage
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-samsung-soc@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594531014694271263?=
X-GMAIL-MSGID: =?utf-8?q?1594730234862002540?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 7:27 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wvla, remove VLAs and replace them
> with fixed-length arrays instead.
>
> From a security viewpoint, the use of Variable Length Arrays can be
> a vector for stack overflow attacks. Also, in general, as the code
> evolves it is easy to lose track of how big a VLA can get. Thus, we
> can end up having segfaults that are hard to debug.
>
> Also, fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/rtc/rtc-s5m.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
