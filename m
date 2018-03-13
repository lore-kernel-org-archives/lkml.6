Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeCMHIh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 03:08:37 -0400
Received: from mout.web.de ([217.72.192.78]:60547 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751892AbeCMHIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 03:08:34 -0400
Subject: Re: [2/9] um/drivers/vector_user: Less checks in user_init_raw_fds()
 after error detection
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: user-mode-linux-devel@lists.sourceforge.net,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
 <d68574df-868c-3a9a-b1fb-2e95b1a452a4@users.sourceforge.net>
Message-ID: <fa32bc3f-b860-aab1-1e84-262add39e24c@users.sourceforge.net>
Date: Tue, 13 Mar 2018 08:08:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d68574df-868c-3a9a-b1fb-2e95b1a452a4@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Yl2lAMqJDewEh4ri1zrLMnLs98GSsLuxo03rrEU7CVA+DtnbmY3
 pF17V6fOPjOtEkJqBKmxHgC41PsaxWS/XmEVWuUysDOBrgUqi094w/wBS1JfGGlz26RwBl8
 msTTCqPCYgNU6lw5E4XVsxVQe7TnEukId2GpOoXRKDCuBx78xl+3Qk8PmyUJ712P0Kl1MRe
 QyDFac35C43eXdB+evaJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BV05YNK2AMI=:dsI03Mn8z7q7CQut49HAbP
 LpvpA5aAp/LXWKm6UmeuJbOgjMi6FfjmYEPki1+r8jXU5YFvw/g3FAIyNYjdyiK3fOZ5PH/vR
 mF0+yMTNqTlimJu7SfIjVKsbcwYgfwqthTNwhxxxoneKyot/YdxH0CvWOTSWeXqr3Ks+2L3b5
 DMe3iY/GBLfesy0CY710BVb4HJYrBO+G8QDdRkL2OkquQUZp55p6nT7dUKblFyhPcgHbM2ekj
 ngBBCZsQpCMAZLVLOV4CGVS8Lf8xMltotiw21G9YKrKvX3WDCbhSyCfYYD4nwvEqg1N9A5uVM
 AloYfRSyCjvQAoef0+3X4MiAtQib6NlBPj2vM1yEyOviZQDsvFsQSlHsOMnghwWdUti3oykJy
 8tdK+JQncsnIMdSy96b4S/W66Zrv2tBzhm4+/kJKbXohhmEWGMoFWMhi9scT6y07+RmnOQwN0
 litMyJIUwMnoGZW/9qMWiokw7bR5YsCLVom4x/eCCtj3Bju3nfS4FmoqfcGsLdjWfvtCOGxbO
 wOTEGRDua+gRoa9NvzLxCLwLA54jsQFtxCyc9Ib9F8sNTAYfnNKGK3oQBpId+SacmO7FlfDWi
 B1su7HEObQnhUSpC0T6SPgrtnTncOAAH5iu59fRyoS1vzDubGCUKAegEYNms3SEzkYlbveo37
 Cm3e+9rJfGLRHPpMOzKamI64DtS6hNkvf698WMjaz4XJ/LR+UNE1Ul18LJtr+anuhI0C6EVce
 9AspAE8nvP8Ck2DkZ7K0qu2tWeNgLAT+QmuTtVmQX1k/yBckc4zY85wCZngwuY+ZJDx3Ph82m
 82PvbiBRGjpn1LjpJyND+yCmsxJpyvd2OnZ4ce7N5jn7hl7kJM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +set_error_code:
> +	err = -errno;
> +	os_close_file(rxfd);

I have taken another look at this change idea.
Now I notice that I should have preserved a sanity check there.

	if (rxfd >= 0)
		os_close_file(rxfd);


Regards,
Markus
