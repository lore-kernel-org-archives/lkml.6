Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523430505; cv=none;
        d=google.com; s=arc-20160816;
        b=hGR0Jbk7H9HKnahbjlqUThIpKKcrcEgrFn4S+V81xjF6EWxRT/4SePZGqE98LwuzAn
         4Aa4Z+z4FacsYGsCKn/wQStQp+y5eoltAu9usPx6KZCMnwEKgrVlzcipZV39xWZVaeUX
         +R4Xb2CyUh+E5uR+1+756SpWzNjRpUY50JtDTlHfN2xnXuC/VhQLXWk+xToZmfLkYH5O
         y3sITFVQ3HBxiIp7oSlVIUhiI+p5G7bYT2646bVDSS8uuXdxn+fntE1mrGQPWKE5Jz+i
         SQhLnuUSR4oYqFhgFGXsiEF7limfs+0Ck9chgc0IxpS659qgA5N/gOmC17Sc3tvaHTlh
         IUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=UH9N5Z8ldFOv8QzfCkkMM6P77iux/AEw6RAzs5K3+J4=;
        b=T06BgHl8aE4yrVp7YshEzo4z50AFHurTTy4LqqhfwI2Mp6YOnZg/Yx1u6CKxHAROPY
         g0iGZ4sXwhxOb5t4ulWpQEdi3/Xu/kFU3vanQzg4G4KyaEyET2TJOWj1Wuixwo/P/gTu
         r4cM+8nmarFs6kuDU5uzg/ozApmNQd2sf6Vz8Uy0TbCGL5ncWEdSpZ1ZYktwSCDUIR4Y
         ijHsuR5CljSLHVl1nwS9dfWOxs3f6Coq14eJPEg3CLtzMb1fagF5eVkwsFUC6tu7fXaN
         jsHs0yqyFAEVj5Zp57DLvy0o9M2WREzrrbbSbIkCaK0cX5NUO989YWaaKB3mOYW1gGvg
         +v1A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YpvwX64X;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YpvwX64X;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AIpwx48k4Jm1DMMlIfrovcEUDVrDZYRxyqwibRtgPShuy0YYcNPPEMzBglnVeGdwxjYduRSCNrjnxw==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Wed, 11 Apr 2018 09:08:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: samuel@sortiz.org, gregkh@linuxfoundation.org, davem@davemloft.net,
	johan@kernel.org, arvind.yadav.cs@gmail.com, netdev@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: irda: Replace mdelay with usleep_range in
 irda_usb_probe
Message-ID: <20180411070820.GF10795@localhost>
References: <1523410435-1693-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523410435-1693-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597411628746023550?=
X-GMAIL-MSGID: =?utf-8?q?1597432665593492118?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 09:33:55AM +0800, Jia-Ju Bai wrote:
> irda_usb_probe() is never called in atomic context.
> 
> irda_usb_probe() is only set as ".probe" in struct usb_driver.
> 
> Despite never getting called from atomic context, irda_usb_probe()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with usleep_range() to
> avoid busy waiting.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Reviewed-by: Johan Hovold <johan@kernel.org>
