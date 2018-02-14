Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031087AbeBNO72 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:59:28 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:54113 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030699AbeBNO7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:59:12 -0500
Subject: Re: [PATCH 1/2] mmc: bcm2835: reset host on timeout
To: Michal Suchanek <msuchanek@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>, linux-mmc@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
Date: Wed, 14 Feb 2018 15:58:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
X-Provags-ID: V03:K0:PtkfTL390ltupgy0uWPlmicN6fziqRrpXUjCAnwaygMVPO6+kFx
 y5qbV4uAl/KDNCxR0H0/By3Q9zFui6480aBnoRoJG5QFE0XCIgHCUwzxwQxwmTP4WzN/ACo
 V3QfsKyvFOLTZ+5En9TkE/82L8vYj/brIs0755RS/8zebfvUuF2FgEcQoc74rV3W1mqQywy
 7rmmqAxRjiEppC3nO88yA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i+mrIsmuTnM=:oUXDMc2Zr1yPPpYZxDSouu
 oXUCunhRKAM+Kxx8Wb/ZQ66xiJW3LZXzNVb083x+xo0acSyIfkECXVvYDWUoYUCpFisZIO5Ka
 tsg4tsaZk/6WPGuqd2qOx/ZEzXzzdKa9ZhLvPnLXE6jHfg7e7MZHWy+dm8J7pabGAzVgRK9HA
 69sPVz79ca9Z143qeTyhsxWiX3RkfnmB+wwoteLtc50VLfBGvKdrheO7PHv4Dk4sUt95zG2zB
 boBaxZGesAyKxHaPe/UQQX9p6KbIGQUL9udzEYRZR0f19wEQ3+YWxXSFXZpHoTVzpVW/JNtfj
 8bfdzdni8dZnY6Y485lgHUFCq5i7BRoXGsrSDlOg6c+Jqc/LqeJuYhfXuC7X1V8NaKWWF3uI9
 CBYVtuBLyELHcrHwVoyp7M0eeQoKV3dgh3QsGQdnv/A7cylPjG3K+xtADH72RR/E8kq38gAqt
 9yRuMp/aQ9Ij74GX5qF6sEqWXzSY+6lNCBofPrZV4ucVwGMTL5oaOcnfyh8ecW46B8CPHGiP3
 q7EswG1CW7TcYn/7T4sVdzCMFLQjiP3YuXX6jCJBoJfQf0jwHR/WViOmJ6aI15EdgmdoBIMtD
 4NAdxUHYZfVhDv5Y9dUEZ4yxVic0jBxQQexCW+WQpU9+J0gppJD19AI4NwZckvMenbMj+bHkg
 a3aWWF/DzQ1BI7aoZPxxCWhBaHgFPavgxIIaYGybiiQhr5m0/FP+DkkWNkEhfIL5qeOmHkgzA
 +R+XnQdD+uuX3ufWzNzsOVoRyGCkpBYWf/ov63MR3XpkbSLljjK+WRMJlqw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Am 14.02.2018 um 15:38 schrieb Michal Suchanek:
> The bcm2835 mmc host tends to lock up for unknown reason so reset it on
> timeout. The upper mmc block layer tries retransimitting with single
> blocks which tends to work out after a long wait.
>
> This is better than giving up and leaving the machine broken for no
> obvious reason.

could you please provide more information about this issue (affected
hardware, kernel config, version, dmesg, reproducible scenario)?
