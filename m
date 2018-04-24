Return-Path: <stefan.wahren@i2se.com>
X-Google-Smtp-Source: AB8JxZoqW1HkWUFKx6/84dtwRuYc3ltWxTUInvSanT/wXKkKal3eTUdM7G3gV7M3QqlmT1rz9hII
ARC-Seal: i=1; a=rsa-sha256; t=1524557661; cv=none;
        d=google.com; s=arc-20160816;
        b=nHVuXRBzt6aF90phXXj5yh2daRmLPOKfu8mB3uGDDublPhyzn/hD0hRCfwOEiUDToR
         keKH/neKmZ+Tkeu7uarCEIjkO45z2cf+LMwlaMuMuPKC0LDja0JrECHER7bi4MS3wIXE
         0b4ea3z/hm8/utbRz5TKl7zF6enL8ZlX/SzydxYfS+orPZt+hvV8S1XmcZ2YLSdMHzsD
         X/daoCINbw/K/Y10dXnNCw2gr6GC86ECPa+2yqYLjSM74NIF8qj/2xiokBa9VG9huoL4
         ULHu7919OrGXlpyWrGt98QrKL1vmvrf5kElXBPnbQFf/oNdyUfHNEasIuBiG9LnB8MGZ
         6WNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=fVHOp0fzpRqInH6nlIcY0GGK94SlTEZU+vtU6w3wqSY=;
        b=M5VSlfSZ+jKkob4Tkk6hA+b0+p6964Z9layX2lONWZWWWfWr2hPKyeIpb4lF+lcuU9
         GxKRq/aruwwx18QAW7RLgncuWDnMOb93OHMBdSXTSLaCklCZjRUOKUW6n5bwK5uPygzD
         MbYao+lbg2DEpIB5F/hv0ru4twGcBqZg75R4O9fD+HBw3xfVgDp1YCcMQ8NFCWuznLyJ
         6n6LbShyLpkrgNttj5LDOfiwQbQ9hIaSrAIN2ns8E4IvCRwZTIIiOq0udnP5/7rp3iyd
         qKpTe1GIC30gKCYeY6YdHBkgVkuwHCgEzdN1kGh9yeZp2vtdjeKmKfYomGfSQ45pk8ZC
         bfuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.134 is neither permitted nor denied by best guess record for domain of stefan.wahren@i2se.com) smtp.mailfrom=stefan.wahren@i2se.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.134 is neither permitted nor denied by best guess record for domain of stefan.wahren@i2se.com) smtp.mailfrom=stefan.wahren@i2se.com
Subject: Re: [PATCH] staging: bcm2835-audio: Disconnect and free vchi_instance
 on module_exit()
To: Kirill Marinushkin <k.marinushkin@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Eric Anholt
 <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20180417050028.19372-1-k.marinushkin@gmail.com>
 <20180423135024.GA2337@kroah.com>
 <7e2dbb73-f93d-7b87-2fa0-d8b40f4a11a5@gmail.com>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <20eae5c0-8e35-2295-f4c4-1d8f65ed63ea@i2se.com>
Date: Tue, 24 Apr 2018 10:14:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7e2dbb73-f93d-7b87-2fa0-d8b40f4a11a5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:hn5sE6W77y/HYZCt4HRQWf0HaldrPwY70Uswwl3en8ztX4P1HjC
 wpvt3yFP9MAqNKI9B5f0Ifd7kuOc851R+u5uwRmKxkzHyUrnpdMpn3SXtRxtlY0GlOHOu2b
 JRrCXZGUgMxb+62TtliZ1GKJqOfWuuyurHpdmD1f986o9ldqOOwjIXJqmfEFn4J2R+uELTp
 mctdeOAEeQHwqYFBy6e3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3c9ZXnsbYy8=:opuRk8afSdzXDpcKRQVHkZ
 ZO394bDBQsDKW8R1XiyUhT+9jPvX3Pk1lxAS2wiyWeqv1zaHaSW5EjdVdiHdG7OY3c25LQEW0
 tpDsKYcXvnowJHptRIH+Gftr1of+W1MRql+V5JUE0DpJrdw/8CmeKZMgI7GnVAUPelVH893f3
 8SxvtVegWiUDOCww+M0JAxF/ewTqyZeM1VQ2S6u3D7W3llzCHkGuDWzUXVFPX5ugKqlx3Nq8g
 1ha2ESktQyjb4MWj2BwubVBauMBnRapuvUrlS1NNaTC/egV+pioxzlsyVOtbRqOU4MrVQUCuy
 6fpvQBXuDJf0lIXUW9QJtDcAPHQjl9wHWBomvQfGqfBsIUXd6sabSXSLIW2Jn/bOjGscVLj2Z
 O0SS54PaDIIupEJeGckqRNNUJ84w4NF+s8jRVnxYv0fxKSf2DwG/nu1rV29N4wz41TnnYbqjK
 mLhsZ43oDJg/qP1e5LmFHmIiNKzhG2hIryRhkvEMRuTo49z6Al2AO5C8oSjw+NY2Bb+68erW+
 WvCHcNMLBcas4UxfYoHcOhsZDfsEipFBFPehQtF1uIlADPpxjHvQebsuI4HoWShPpHv2a5RTs
 7CVpXmHx6ch8e1vBM4zpgGEWpqoxytfb+tXE+OuXOAd0coGCoi+5ZhCURnDFaeUcOE55El9/5
 mW3WoZSQtoC+q7QH9znoA6bfx5zUTOjfA8qCiDOlw3gn6xfc34wOBbqzyPi4iKVuevYs15niH
 0oMNlvpi/o+tvoYaZhCerz+k5uwnFv8ikwiNs98HpXP6cDGsgOX7snMr2GU=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597968190615569586?=
X-GMAIL-MSGID: =?utf-8?q?1598614574714313463?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Kirill,

Am 24.04.2018 um 02:35 schrieb Kirill Marinushkin:
> On 04/23/18 15:50, Greg Kroah-Hartman wrote:
>> On Tue, Apr 17, 2018 at 07:00:28AM +0200, Kirill Marinushkin wrote:
>>> In the current implementation, vchi_instance is inited during the first
>>> call of bcm2835_audio_open_connection(), and is never freed. It causes a
>>> memory leak when the module `snd_bcm2835` is removed.
>>>
>>> Here is how this commit fixes it:
>>>
>>> * the VCHI context (including vchi_instance) is created once in the
>>>    platform's devres
>>> * the VCHI context is allocated and connected once during module_init()
>>> * all created bcm2835_chips have a pointer to this VCHI context
>>> * bcm2835_audio_open_connection() can access the VCHI context through the
>>>    associated bcm2835_chip
>>> * the VCHI context is disconnected and freed once during module_exit()
>>>
>>> After this commit is applied, I don't see other issues with the module's
>>> init/exit, so I also remove the associated TODO task.
>>>
>>> Steps to reproduce the memory leak before this commit:
>> <snip>
>>
>> Patch dropped due to kbuild complaints.
>>
>> Please fix up and resend.
>>
>> thanks,
>>
>> greg k-h
> Hello Greg,
>
> Due to which complains of kbuild is the patch dropped?
> I would like to fix the complains, but I don't see any errors or warnings on my
> side.
> Are you sure that the kbuild test robot did it's job correctly? The log says:
>
>>> it may well be a FALSE warning
> Please show me what is wrong in my patch.
>
> The log from kbuild test robot says:
>
>>> [auto build test WARNING on staging/staging-testing]
>>> [also build test WARNING on v4.17-rc1]
>>> [cannot apply to anholt/for-next]
>>> [if your patch is applied to the wrong git tree, please drop us a note to
> help improve the system]
>>> url:
> https://github.com/0day-ci/linux/commits/Kirill-Marinushkin/staging-bcm2835-audio-Disconnect-and-free-vchi_instance-on-module_exit/20180417-193147
>>> config: arm-allmodconfig
>>> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
>>> reproduce:
>>> wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>>> chmod +x ~/bin/make.cross
>>> make.cross ARCH=arm allmodconfig
>>> make.cross ARCH=arm
>>>
>>> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
>>> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
> I cannot clone from the given url, because it does not exist.
> I cannot use the compiler from the log, because it is built for x86_64, and my
> host machine is i686.
> Below are the steps how I tried to reproduce the issue, but errors or warnings
> didn't happen.
>
> I applied the patch on top of the following upstream tag:
> 60cc43fc8884 (tag: v4.17-rc1) Linux 4.17-rc1
>
> And executed:
> make CROSS_COMPILE=arm-linux-gnueabihf- --jobs=4 ARCH=arm allmodconfig
> make CROSS_COMPILE=arm-linux-gnueabihf- --jobs=4 ARCH=arm
>
> But the compilation succeed without any errors or warnings.
>
> My compiler version is:
> arm-linux-gnueabihf-gcc (crosstool-NG linaro-1.13.1-4.8-2014.01 - Linaro GCC
> 2013.11) 4.8.3 20140106 (prerelease)

this is an old toolchain. You can download newer ones here (even for i686):

https://releases.linaro.org/components/toolchain/binaries/7.2-2017.11/arm-linux-gnueabihf/

Best regards
Stefan

>
> Best Regards,
> Kirill
>
