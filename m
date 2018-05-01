Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756287AbeEARtG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 13:49:06 -0400
Received: from foss.arm.com ([217.140.101.70]:49876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756246AbeEARtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 13:49:05 -0400
Subject: Re: [PATCH v9 02/11] kexec_file: make
 kexec_image_post_load_cleanup_default() global
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-3-takahiro.akashi@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <cbf66675-1671-32f9-1410-a76986becf85@arm.com>
Date: Tue, 1 May 2018 18:46:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180425062629.29404-3-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 25/04/18 07:26, AKASHI Takahiro wrote:
> Change this function from static to global so that arm64 can implement
> its own arch_kimage_file_post_load_cleanup() later using
> kexec_image_post_load_cleanup_default().

Do we need to call kexec_image_post_load_cleanup_default()? All it does is call
the image-type fops->cleanup(), which you don't implement in this series.

Is this just-in-case someone adds cleanup() later and is surprised only the
arch-level helper is called?


Thanks,

James
