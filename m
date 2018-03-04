Return-Path: <deller@gmx.de>
X-Google-Smtp-Source: AG47ELtqb6vmKr2M0/xUAQI4zopGhysU8GRjaVKwqMZGqtA/PXWJPxtbdrNFWVeivAXV3J9xyXDO
ARC-Seal: i=1; a=rsa-sha256; t=1520196376; cv=none;
        d=google.com; s=arc-20160816;
        b=FDngMQwTWym4Jw4CPU/G7STr8vIP+DjC5qpHs3dRCj6vHonp9nc1aH2bpsOBGtZ9NI
         s8rvhnW8CARBfoYGdw2Ep02PTB8CSGEMNHO6I+xUXYSnSA9jwz2EwhtRY3+y9zhgQj82
         C2GdIzZafmy54f/5b+OyahiRkpXnb4MNfibQp6qej/1RyoGsRRmMQWJWrVPGJGAYnwHf
         qOrgX9jFrkWZZ4FiB0bY2b5+dIME8GDVG9euo2H2IA1bowQOet/S+M7kgyMIJ07xKAi3
         GSShBTpnR1cNG2tgEy858u+QIp5+8gTWCZVv7qAzFgp9GcJC3MqPudlS331aafx5gUr5
         tNWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=QTH6vLHaYY1poKpYGkewFOWV3shi+iIos2KGc0/UGhU=;
        b=OsPiEGfjLJKe3QhdbUgHIPbssdzw5YzQRXJaz08e3olwL/kEBn7mPipjakSmkoOTis
         nanEvFpBPUm9z11Py3tUWFEh0MgEkE/1O3WprKyHRHlH2EU0oaQMotU+jJOgrgc4XwmV
         t77a6PWRtJAB5Sw9v5HS0VzWnO8faYblLPFDuoshQCfnJSJAn1gk9EZDv3glUTkURuPw
         lm5McbbahCZWsq8Z4tUQZUYzwWy1GutgDgHpHX+rLBgFHqG9vWTpCx8G+psnulc7/KM1
         Tu7EXAwvLuRDZzjY6woR27MMdTZPDff2onZQx208vmHRxCsLOx8kH1sPRU25Fcjedc42
         dT2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of deller@gmx.de designates 212.227.17.21 as permitted sender) smtp.mailfrom=deller@gmx.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of deller@gmx.de designates 212.227.17.21 as permitted sender) smtp.mailfrom=deller@gmx.de
Subject: Re: [PATCH v3 02/10] include: Move compat_timespec/ timeval to
 compat_time.h
To: Deepa Dinamani <deepa.kernel@gmail.com>, tglx@linutronix.de,
 john.stultz@linaro.org
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
 acme@kernel.org, benh@kernel.crashing.org, borntraeger@de.ibm.com,
 catalin.marinas@arm.com, cmetcalf@mellanox.com, cohuck@redhat.com,
 davem@davemloft.net, devel@driverdev.osuosl.org, gerald.schaefer@de.ibm.com,
 gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com,
 hoeppner@linux.vnet.ibm.com, hpa@zytor.com, jejb@parisc-linux.org,
 jwi@linux.vnet.ibm.com, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com,
 mpe@ellerman.id.au, oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net,
 paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
 rostedt@goodmis.org, rric@kernel.org, schwidefsky@de.ibm.com,
 sebott@linux.vnet.ibm.com, sparclinux@vger.kernel.org,
 sth@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, will.deacon@arm.com,
 x86@kernel.org
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
 <20180116021818.24791-3-deepa.kernel@gmail.com>
From: Helge Deller <deller@gmx.de>
Message-ID: <e417db45-d400-3513-3897-7aefa9889711@gmx.de>
Date: Sun, 4 Mar 2018 21:45:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180116021818.24791-3-deepa.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:MpMQueG6fpJGABwaNaKFGGPOKFbCttoGXhtORnzUxN0TeRnHuj/
 iv9rWFxZqi9qg3gcqVbT+dtDvixDr9swhecwWhZlA94A1Xiw3VXwiRw8ZUIrulE5D1UKLjo
 Z4FN7O1FsLXQ8s0rX7ZP1D3hYZTndpk/6748qAYxHqFMZa35S741kAFpmnknTcMsuCNott6
 B/V1DL4i//42UpWJ/LedA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OV4kiWFkRWI=:Zjz3I+8dOWxm8ofVddNREF
 Z6o663WahrkDiir9gy2dE1nbkwcG4WKeI+uHtn45FWP2S/j+kfixXt7bq0BQ97RAm9M3Sy02a
 U8bzES/0FfEnxZtcCA7H7wvlSPudYJV0K1sLw7ZXhdkJ1HnA7cglpLDKPPsuccjhSZ1NDzKwL
 qjD+COx/bqNucrsEMDQg9WYYEr0SoRBFaSEC4mOzxtyG3nmzxXQW1/DqEyljquZAvGEzhP+p6
 4ocAIikLcPcCNSXybG0oF/mKH1OGmxGWc+dWMaZEH6TxsPEFDJB7rD+0z0BotiMwBUlhob9eT
 +ab1amN7QW8vY74afTd7RKMI0S+Utx8/erVeTTEyGFaB41g25pfySnDbRsBosDh9RGJRuikZ3
 6mne4Lw5lvz6X58ObQktsX/mfPipuqEfu5c87/gq4bBqe/JL/B3eC0tDnzsY+WoglqemzS9NC
 hTHhAJEKlGxOTQh85ECDOCXKgefFY4JSwrCmv9zj0WuBCSGk+Ru0XVEPAiDKPRqJBU/pGfXyC
 bJEneE1WdehvIW+0b5t8iXfx6+VbYWOxqYOOOhwtFTzejGO4hGh2QxpthK/i4/H10Obm+kN+m
 6X3NchYQqQmV1cNBmuNTWlbJJ3OVFddZ/ZvdEjyzQi0g/KXF+9Yh347EZYcx9JEin58OhYxFV
 sdGoJvIERzeMrxDC7Fg2ZtczS8BUEKp3lOZAUCN7HCDZv4VKT60+MOpc7gK71zIA/RoNP0pl4
 q6nwiKiVmfAtFIr4YCiOLOM9BsR4otmfXuer9cm6tDUxAkJ+Xgl+r0ag36TG9MH+yUgNEhJ2u
 dudavpcWOpweVf16u42Grc7LnbzFbFhQl03QppVwJNfjba55KE=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589713718016333322?=
X-GMAIL-MSGID: =?utf-8?q?1594041435276827618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16.01.2018 03:18, Deepa Dinamani wrote:
> All the current architecture specific defines for these
> are the same. Refactor these common defines to a common
> header file.
> 
> The new common linux/compat_time.h is also useful as it
> will eventually be used to hold all the defines that
> are needed for compat time types that support non y2038
> safe types. New architectures need not have to define these
> new types as they will only use new y2038 safe syscalls.
> This file can be deleted after y2038 when we stop supporting
> non y2038 safe syscalls.

For parisc:

Acked-by: Helge Deller <deller@gmx.de> # parisc
