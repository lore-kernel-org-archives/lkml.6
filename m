Return-Path: <kernel-hardening-return-12458-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsXq5oiIKczxVgsj8X7Dmhw7XY9XQk6bHxQHUPLflTnTta6MsQgPNJGlVsKoEEWlsnUhtpC
ARC-Seal: i=1; a=rsa-sha256; t=1520859023; cv=none;
        d=google.com; s=arc-20160816;
        b=YupwcBUTbDMufoeZB5PExHl1y16Uy9K/wiQQ3anKnbURh1qWG4VPCGvJUO7RPkOzRg
         9+8Pe+jN7MdGapFFCyvc/VD/bi+kmvnbX8lhTFXo/f5ydMnrkQ+bfUwSBXSB704CR9Ql
         oZIjXQwfIj/9/pZJKmp3qlRqEUq4mdJovVJxgNxNt3anl+EcyDm48RbgjbRYbfG4apjC
         nEpXZzohF/z8s8RPDT487h3m+ExTV1RaNIVEryAkwruYJpVCK0ZCQU/AZrlmDL6Bjy5t
         JohofEs8e3vDTmt017PKeS3Yy2QIuuo3fkfAicR2GhuFYxeuuR/rcbU9fnLfYYrTJhqh
         CzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:delivered-to:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=EPfUvXNE6iJVofDYx0vP/6KGvM26M7yB+ZZdHbywUmQ=;
        b=YBJQuKyEzghpzKXy6DzlMm0slXHbOUkymi7n3GSLK6ftuWbp6LpdzvOAi6JOd3DfuK
         6OpbHL1NQ3QbVxrluHJ2Ndyx7+fXrkdpjpwpwNFd4WsfrgrGuLsRezfMmxvpkrIZlZ5u
         hrDi8qV82FUpJoIeSD1ZsT70Q6uwp3LlPsfH8hj/ixsoe3KETsSTfmYkXbZJlfZ5BjOi
         2gOv8ZwS5XzKWo8Al9DuY12UbvH1nbZQ6T9tWKXqjGj+LJjvizDQvGf3m70qrM/gwvO7
         JIBPpeANkl8t3Dd8KdEwhzDjbnn5sfXWqQ26/xCMaHYxENabMd9MW1O38EGwEIMRDCaN
         I7nA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Fsv+87Q1;
       spf=pass (google.com: domain of kernel-hardening-return-12458-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12458-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Fsv+87Q1;
       spf=pass (google.com: domain of kernel-hardening-return-12458-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12458-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 12 Mar 2018 08:54:08 +0000
From: Lee Jones <lee.jones@linaro.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH 1/2] rtc: s5m: Move enum from rtc.h to rtc-s5m.c
Message-ID: <20180312085408.juqhh5pvgno5zag6@dell>
References: <cover.1520660422.git.gustavo@embeddedor.com>
 <44ee5bd5053d579dc6c46b21e2ef8f6acf70e4ce.1520660422.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44ee5bd5053d579dc6c46b21e2ef8f6acf70e4ce.1520660422.git.gustavo@embeddedor.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594530993391759902?=
X-GMAIL-MSGID: =?utf-8?q?1594736271080957466?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 10 Mar 2018, Gustavo A. R. Silva wrote:

> Move this enum to rtc-s5m.c once it is meaningless to others drivers [1].
> 
> [1] https://marc.info/?l=linux-rtc&m=152060068925948&w=2
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/rtc/rtc-s5m.c           | 11 +++++++++++
>  include/linux/mfd/samsung/rtc.h | 11 -----------

I don't think this will conflict with anything (unless some major
works are carried out within the next few weeks - in which case I'll
need a pull-request, but for now ...)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
