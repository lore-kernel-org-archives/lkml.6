Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966922AbeBNIVT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 03:21:19 -0500
Received: from mout.web.de ([212.227.17.12]:60417 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754556AbeBNIVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 03:21:17 -0500
Subject: Re: efi/apple-properties: Checking error handling in
 unmarshal_devices()
To: Lukas Wunner <lukas@wunner.de>, linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <145f8fac-9297-b362-d89f-886632e2507f@users.sourceforge.net>
 <20180213184033.GA24299@wunner.de>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <af278523-44af-3483-8503-10ec93f7a6c6@users.sourceforge.net>
Date: Wed, 14 Feb 2018 09:21:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213184033.GA24299@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:CTh4LtVfJErdJ2fZa4SLYfZj88er1ub4g+ETkHjiN8aAdezfZYJ
 biK2+YofDaM9p3ibu/0FNVOXwRfcxdd3zKylN8t6/JfAr1VsQ7fNoKiV2smjSyD3/eRjELl
 3hAxMjsMSzGQsFNgsb7hI1zUjsQShgEmxlJ2CPp3FmMhAoQbGFDg4icRutVNPQy7pxyLBDP
 l3kXopvag9+dqgKbsl3gA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HqZ+bzO2Mz0=:gH0fUEfeN5oEqgBLiGAdlp
 fkw1UpGAh3C5Y0shPgldpGL8lz26OzyLdQHahdRQ0TJvk3o7QLmhkw6NARNY52x0Uxy3XElrT
 gI3dC7hxM5ReG5SSMWUgYiVGACPZN5CIFV2wo7A/Zy35AjUwqrqKyinVg7QMTLkfLv5FluoYA
 TxHnDG90lHD2yfhSN5mJnTWikpNXKtmxh44KrUnCxakeOP/rLKfrZSu64mtk26rR9s2ZgpYpi
 yPpTHjGKQE8PbbZiKZGGAFVcoiLPMKP2BwXDtI6qusPCzVWNIfls8VNtgiazENTfE2nKsOD2J
 twsTysP94yRp4aW0mEBdZYII2sb/yqgnVmleLdXvO/0+rvjaO7fjVXKLAchP+JLN3VWS/7e+L
 oNs/mkMa1q1wrFKcDgbw7y8gx86IdajcIvqUV2jbVPKnMf6Jdu+7BPnl2RFheIVb4EvUn3v+v
 kwyNfCQPFTd0CyYOMNW8Q9SLIcnFxZYyCHwkuBj62X1WCX5Q90bJpQgGuTghGz1dyhomL4ESN
 zwBTJSMvCIOyatP+yP4mVVgTsyZ6akQOrBVapX8SSfTKS4/KzTe6R6J+1a5rXQASCLPZohyAX
 GgpxrH1piYjnXncXTZTiXn1pHAx6uZzGg3jLRqCFSs4ABxEgwExBPVXTZyYqlLJtvrQ/1hMkl
 dV1B5LeVkMQTaDwrXZjGyTbdXwTq28OZtopoOatCqcs4pCspI2Niqtk6WWPjhSgxLVsAz216S
 bRR6V/4wr+/1qJVZb3z1g/LFIWwqMfgvOiiipiJ4UTYkeor03N05mX0a1ILx7Wnj3ccjmIDvl
 ShXmQ1xunjGjfshx8UkvEzd6CzCWE/UDYCGm6N+BvHr6GveJgE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> While the allocator does print an error when allocations fail,
> it may not be immediately apparent to the user what the
> *consequences* are.  In this case, the consequence is that the
> device properties will not be available for consumption by
> drivers and they may fail to probe or behave in entirely
> unexpected ways.

Would it make sense to indicate such a questionable software situation
be any return code?


> Hence I deliberately printed an error message here so that the user
> can make the connection between erratic behavior of drivers later on
> and the memory allocation error here.

Do you find this terse message really sufficient?

Can the mentioned properties be required for the desired system configuration?

Regards,
Markus
