Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELvjos0/Wco5juGUmRMSYOI7yVPILjwedt8Hj6qGWv6t+qMrUQTsV+kvfx++VdmlB/+EvKOS
ARC-Seal: i=1; a=rsa-sha256; t=1522055722; cv=none;
        d=google.com; s=arc-20160816;
        b=GNQHnMGcgJCb3psYOwajoTAVabnu5zcXLiRh8mTVZ5xbODErBilqFHuZ0lKj0O/B4E
         S4Iby/f+1m7hhcBBP7vcOLo05hIQhnbdgNLUAwCxYW6YevfN7qDr/DXzpz1m308+QMlY
         AKMyfzmWwfhQgNBqNG6JIbYo6wT66qorpuQkJopHDoYxHxXstrzYFiY5HNLKWxv9ClHI
         Aaw/iCzdPYYJip9Hz/Lv8mAZvXysDVyhooboHMi1hESrnxT21p5qTULXMhyOAhdIoomN
         9ztx8FmAjfdXo+pBMdAd9jcsRBAK3gJ65sdmC+xSZAvrgok5J3GUA6R8lzQb1E/oOg+g
         U0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:arc-authentication-results;
        bh=d5DboWJySvfep/AiRr1qR+5YJMAGkJM7tn05GQG2M8I=;
        b=yZvdWDx6gDNVCzJEPEi3PsJ1QcNXzNFuFJQnPbkZ4Yn2f5jEW910Ua67n7K9sUtr9U
         w26VAMCWxuWV0UgkKLf0o7hKN7/hv+v3F4UVuCE2QMNMyqEWA4TWfLkqT+zjDQAHPMHj
         G4nX7J7PpFkHeNezRg/TpPlFIwqeb+9DOAlHt/0j2dE9oNLIUxJlk6+Ulp+az6zHIFtL
         y1udiKJR3OU86pfT1SH4BMeghmNAIak2XhocvpTKAA0h22UpsVLCfxwADXNCqjOBj3hV
         +67+40YNHFs40vA6vf7rTqWnDU8acCov/xXXirEVyVP7TdKQT5rxG7mffWj6IiW9xqre
         uhag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
MIME-Version: 1.0
In-Reply-To: <201803252111.2HMcV5IS%fengguang.wu@intel.com>
References: <20180324041027.6498-1-quytelda@tamalin.org> <201803252111.2HMcV5IS%fengguang.wu@intel.com>
From: Quytelda Kahja <quytelda@tamalin.org>
Date: Mon, 26 Mar 2018 02:15:19 -0700
X-Gmail-Original-Message-ID: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
Message-ID: <CAFLvi237jR_tTQMXBNqCO=NQFOEFiJQkDBMxb_AxgBEqQDYQEw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ieee80211: Replace bit shifts with the BIT() macro
 for WLAN_CAPABILITY_*.
To: kbuild test robot <lkp@intel.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: kbuild-all@01.org, Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K0:0g3IdY/wSLpGAzgH744w2LXAfWApq2rEo8zivSEpGnk3qKvjGlh
 HDeBw87LmhIcMm7jrXndjA0nBTJ9c5RTdE/Xs3gUBYUXcbcWS596wNyTobHLVoCTcszuHRy
 t5XqiOF01llLvJgPFvAkPKnHaH4abIj2C0+oeFfKcCFS8vxJvHaVYsLHRtqqEvQUh9yuC7F
 34C/j/3Qj3AnDXKJkaCZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xEE0WnJZqBY=:Njb7mtDp316NwVnnoL1lOa
 2XODYyQGWxyMNxXqlN3uQlgx01CNaM8gaYB5kcXTUXo+mOfqzh9RBahkzzMwJ4GtxrjnrSgG6
 KM+GMLQJfhUyjWUl6fo3k9NoHLERP0GDsxTERP5BaWJJotqzFD5j+W3uwAtqa3Sek1yqSHe5F
 OjQFcD4ZkLdjil6/TVsfmWoqW5lhONSldITGgAnYMd/LG4/XPNIki/dsQn3YyW5oTgkEzaCEa
 EvdM8viVc8eIFZjZHtqs7kgQ6W63b93BXONQ+jECnFotyQdlpU++Awz+hQI38ResC0lY6qqVB
 aSKC5qLyj+Eil09jc+xeEYSJXIADATR8BriXnZIMLJyz1BJ9y3LBRpy1cPb0oCCQLJiHLQWMT
 X8bFD/IDm+9289zPCPvNd27HEwhdI2Tpa/xlwzzWQeCct2LPKsY7iPnau8IpZooqjPYGGMvzj
 gxKxCLvu1Q9qEQWnElgi2+CgfbocLAqddhIn37qdmYxkt1hz+1Gos01+rvxYbJ3Gci7qnLKSF
 JqUqnLeFN+UXUc1GzyiQYtnB2Drs0F7rzOsAjfMXfvsqikNb4fEuQpbvydCiCoSGuGIiLK2b5
 qj108c+gDqt2bhLiVe14IVWqJZa9fdE3YS0U59q8Z08mHKSOhmtM6X0eNc6kQnaWchL3tECsu
 vqOmbygT6Ebr27EpQ6qQgsrtZ0NBwMo8UA6HnNg5OxkXKJTIILxqXybWUbR39a2KQe9v3srNB
 44BhU0+zaxxaXzvCZiHwxA1UmKu1YDsuOpuYt8fL5uvCpWCXNk4RP2QKY3w=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595991101205290276?=
X-GMAIL-MSGID: =?utf-8?q?1595991101205290276?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a problem with the rtl8723bs driver in staging; it's source
tree has a custom IEEE80211 header which imports 'linux/ieee80211.h',
but redefines many of the #define's from the original header.
Functionally, they are the same, but I will submit a patch in reply to
this email which removes the duplicate #defines from
drivers/staging/rtl8723bs/include/ieee80211.h.  It looks like there's
also some #defines there that shadow enum members in
'linux/ieee80211.h', but I will address that in separate patch(es)
when I have a chance.

Thank you,
Quytelda Kahja

On Sun, Mar 25, 2018 at 7:05 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Quytelda,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on mac80211-next/master]
> [also build test WARNING on v4.16-rc6 next-20180323]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Quytelda-Kahja/ieee80211-Replace-bit-shifts-with-the-BIT-macro-for-WLAN_CAPABILITY_/20180325-211645
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
> config: i386-randconfig-s1-03251817 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All warnings (new ones prefixed by >>):
>
>    In file included from drivers/staging/rtl8723bs/include/drv_types.h:33:0,
>                     from drivers/staging/rtl8723bs/hal/rtl8723b_dm.c:20:
>>> drivers/staging/rtl8723bs/include/ieee80211.h:444:0: warning: "WLAN_CAPABILITY_IBSS" redefined
>     #define WLAN_CAPABILITY_IBSS (1<<1)
>
>    In file included from include/net/cfg80211.h:23:0,
>                     from drivers/staging/rtl8723bs/include/osdep_service_linux.h:50,
>                     from drivers/staging/rtl8723bs/include/osdep_service.h:23,
>                     from drivers/staging/rtl8723bs/include/drv_types.h:29,
>                     from drivers/staging/rtl8723bs/hal/rtl8723b_dm.c:20:
>    include/linux/ieee80211.h:1593:0: note: this is the location of the previous definition
>     #define WLAN_CAPABILITY_IBSS  BIT(1)
>
>    In file included from drivers/staging/rtl8723bs/include/drv_types.h:33:0,
>                     from drivers/staging/rtl8723bs/hal/rtl8723b_dm.c:20:
>>> drivers/staging/rtl8723bs/include/ieee80211.h:445:0: warning: "WLAN_CAPABILITY_CF_POLLABLE" redefined
>     #define WLAN_CAPABILITY_CF_POLLABLE (1<<2)
>
>    In file included from include/net/cfg80211.h:23:0,
>                     from drivers/staging/rtl8723bs/include/osdep_service_linux.h:50,
>                     from drivers/staging/rtl8723bs/include/osdep_service.h:23,
>                     from drivers/staging/rtl8723bs/include/drv_types.h:29,
>                     from drivers/staging/rtl8723bs/hal/rtl8723b_dm.c:20:
>    include/linux/ieee80211.h:1603:0: note: this is the location of the previous definition
>     #define WLAN_CAPABILITY_CF_POLLABLE BIT(2)
>
>    In file included from drivers/staging/rtl8723bs/include/drv_types.h:33:0,
>                     from drivers/staging/rtl8723bs/hal/rtl8723b_dm.c:20:
>>> drivers/staging/rtl8723bs/include/ieee80211.h:446:0: warning: "WLAN_CAPABILITY_CF_POLL_REQUEST" redefined
>     #define WLAN_CAPABILITY_CF_POLL_REQUEST (1<<3)
>
>    In file included from include/net/cfg80211.h:23:0,
>                     from drivers/staging/rtl8723bs/include/osdep_service_linux.h:50,
>                     from drivers/staging/rtl8723bs/include/osdep_service.h:23,
>                     from drivers/staging/rtl8723bs/include/drv_types.h:29,
>                     from drivers/staging/rtl8723bs/hal/rtl8723b_dm.c:20:
>    include/linux/ieee80211.h:1604:0: note: this is the location of the previous definition
>     #define WLAN_CAPABILITY_CF_POLL_REQUEST BIT(3)
>
>    In file included from drivers/staging/rtl8723bs/include/drv_types.h:33:0,
>                     from drivers/staging/rtl8723bs/hal/rtl8723b_dm.c:20:
>>> drivers/staging/rtl8723bs/include/ieee80211.h:447:0: warning: "WLAN_CAPABILITY_PRIVACY" redefined
>     #define WLAN_CAPABILITY_PRIVACY (1<<4)
>
>    In file included from include/net/cfg80211.h:23:0,
>                     from drivers/staging/rtl8723bs/include/osdep_service_linux.h:50,
>                     from drivers/staging/rtl8723bs/include/osdep_service.h:23,
>                     from drivers/staging/rtl8723bs/include/drv_types.h:29,
>                     from drivers/staging/rtl8723bs/hal/rtl8723b_dm.c:20:
>    include/linux/ieee80211.h:1605:0: note: this is the location of the previous definition
>     #define WLAN_CAPABILITY_PRIVACY  BIT(4)
>
>    In file included from drivers/staging/rtl8723bs/include/drv_types.h:33:0,
>                     from drivers/staging/rtl8723bs/hal/rtl8723b_dm.c:20:
>>> drivers/staging/rtl8723bs/include/ieee80211.h:448:0: warning: "WLAN_CAPABILITY_SHORT_PREAMBLE" redefined
>     #define WLAN_CAPABILITY_SHORT_PREAMBLE (1<<5)
>
>    In file included from include/net/cfg80211.h:23:0,
>                     from drivers/staging/rtl8723bs/include/osdep_service_linux.h:50,
>                     from drivers/staging/rtl8723bs/include/osdep_service.h:23,
>                     from drivers/staging/rtl8723bs/include/drv_types.h:29,
>                     from drivers/staging/rtl8723bs/hal/rtl8723b_dm.c:20:
>    include/linux/ieee80211.h:1606:0: note: this is the location of the previous definition
>     #define WLAN_CAPABILITY_SHORT_PREAMBLE BIT(5)
>
>    In file included from drivers/staging/rtl8723bs/include/drv_types.h:33:0,
>                     from drivers/staging/rtl8723bs/hal/rtl8723b_dm.c:20:
>>> drivers/staging/rtl8723bs/include/ieee80211.h:449:0: warning: "WLAN_CAPABILITY_PBCC" redefined
>     #define WLAN_CAPABILITY_PBCC (1<<6)
>
>    In file included from include/net/cfg80211.h:23:0,
>                     from drivers/staging/rtl8723bs/include/osdep_service_linux.h:50,
>                     from drivers/staging/rtl8723bs/include/osdep_service.h:23,
>                     from drivers/staging/rtl8723bs/include/drv_types.h:29,
>                     from drivers/staging/rtl8723bs/hal/rtl8723b_dm.c:20:
>    include/linux/ieee80211.h:1607:0: note: this is the location of the previous definition
>     #define WLAN_CAPABILITY_PBCC  BIT(6)
>
>    In file included from drivers/staging/rtl8723bs/include/drv_types.h:33:0,
>                     from drivers/staging/rtl8723bs/hal/rtl8723b_dm.c:20:
>>> drivers/staging/rtl8723bs/include/ieee80211.h:450:0: warning: "WLAN_CAPABILITY_CHANNEL_AGILITY" redefined
>     #define WLAN_CAPABILITY_CHANNEL_AGILITY (1<<7)
>
>    In file included from include/net/cfg80211.h:23:0,
>                     from drivers/staging/rtl8723bs/include/osdep_service_linux.h:50,
>                     from drivers/staging/rtl8723bs/include/osdep_service.h:23,
>                     from drivers/staging/rtl8723bs/include/drv_types.h:29,
>                     from drivers/staging/rtl8723bs/hal/rtl8723b_dm.c:20:
>    include/linux/ieee80211.h:1608:0: note: this is the location of the previous definition
>     #define WLAN_CAPABILITY_CHANNEL_AGILITY BIT(7)
>
>
> vim +/WLAN_CAPABILITY_IBSS +444 drivers/staging/rtl8723bs/include/ieee80211.h
>
> 554c0a3a Hans de Goede 2017-03-29  442
> 554c0a3a Hans de Goede 2017-03-29  443  #define WLAN_CAPABILITY_BSS (1<<0)
> 554c0a3a Hans de Goede 2017-03-29 @444  #define WLAN_CAPABILITY_IBSS (1<<1)
> 554c0a3a Hans de Goede 2017-03-29 @445  #define WLAN_CAPABILITY_CF_POLLABLE (1<<2)
> 554c0a3a Hans de Goede 2017-03-29 @446  #define WLAN_CAPABILITY_CF_POLL_REQUEST (1<<3)
> 554c0a3a Hans de Goede 2017-03-29 @447  #define WLAN_CAPABILITY_PRIVACY (1<<4)
> 554c0a3a Hans de Goede 2017-03-29 @448  #define WLAN_CAPABILITY_SHORT_PREAMBLE (1<<5)
> 554c0a3a Hans de Goede 2017-03-29 @449  #define WLAN_CAPABILITY_PBCC (1<<6)
> 554c0a3a Hans de Goede 2017-03-29 @450  #define WLAN_CAPABILITY_CHANNEL_AGILITY (1<<7)
> 554c0a3a Hans de Goede 2017-03-29  451  #define WLAN_CAPABILITY_SHORT_SLOT (1<<10)
> 554c0a3a Hans de Goede 2017-03-29  452
>
> :::::: The code at line 444 was first introduced by commit
> :::::: 554c0a3abf216c991c5ebddcdb2c08689ecd290b staging: Add rtl8723bs sdio wifi driver
>
> :::::: TO: Hans de Goede <hdegoede@redhat.com>
> :::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
