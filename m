Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x224ypOuUSYIKCeWIIcKOvUxOjl1WrRbptZgo0bE/Msg5TqZ/Zx/aJHICQH9U51eBPwbJi7k7
ARC-Seal: i=1; a=rsa-sha256; t=1518817291; cv=none;
        d=google.com; s=arc-20160816;
        b=IU/3bTweTTUauva/ZsZAVA5hIk8VlB3C+L2AaTGacZf0kBNxZ/GTlUpPqlypH2VKiZ
         NyE8OPpufTbjAEaiNWwkU9fjZX3E5Ri4vjH9KLOajwML+qPDue6OuO1jKBa80TvKbVFu
         w/EeuZ2jWD6vPJAt/svmp8feDlAW3Yv7kAUTdNus+UuguRCSBggNSHa4t2Uii/EZf7ih
         r1zxls7LBNr8QLpZs2/gS5a7PR5QlDWOb8qJoOD87zeUozn2aBtIEMnhUSXn4HbptOnQ
         Ff/DwHIEZqHx09wmT0HLpQML/8LXOVGvi5AYhVLfhoR6TSVqKhMbElIYbnhA2/3D//dX
         zYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=la0EpflOax1GvXPywbQaQCJ7trG2HHSnQfyiPOo672w=;
        b=Fb2ZnTHcB3BKeRNVV2/Sv0rNwgN2eWvBtUxGEP1/X2R+NFqy9Auvpb0IymbGa7A9Xh
         FpYGoSn7MI2y6Ta8nTCI+wrX8RJcBzKYre9HtZnFQ6GXHMGuPgowO/nNgW0KEv8Fxz12
         +wtH2MXd/DYaq3WbC17azdATT9zom7dkVBRC5QVg8zoDx3HfM558VCZNA07jD/t7NlrX
         LwoHqzo/Ysb1CF/agFaKozZXb/WZp4Y8321Hth2C0g9lnX4w9Be0cKK/s42RarYXQFGP
         Teut0YinlWUpp8ObTqifQnYWtRgQ0B95p6eWIz59LGQ6JA+kiVBo9uT5UQwnNQbnI6/C
         XkQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.17.10 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.17.10 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kbuild@vger.kernel.org
Cc: "Yann E . MORIN" <yann.morin.1998@free.fr>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Michal Marek <mmarek@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/3] fixing the last failures in randconfig builds
Date: Fri, 16 Feb 2018 22:41:10 +0100
Message-Id: <20180216214117.1947175-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:OTtfIdLi0xl8elqh13/nStc/R7vyC4uUPHVTzOnG+hah7cBIxnS
 +0sa36ffhLaUjGMlDWn9IaDHNQyNl85A9QdirCN4LGmBdRSE5II05kSvXfA+9hwfxrHKNnO
 VtBE3O+EW/smeDaR7QWVTmajRmhwyKqBnnVDeCiFrAHTPH/oFpAZb/zIoOAJvMH+NY3B23v
 XMHHGyneiWqsmRIkQpPAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MxZT5Y+YpbQ=:i2wLFtbvIZ8Mf4Ow4O5paq
 2Pk3hzCrUGPQJoYWlgQk/Z3XB+y4bsTkyDdWvon82xbARnuL3o1YkNYrMbOs/uzjFTeNBaDfJ
 YreWOSwHUCIRkOtYHQ/iY/RwNbzT53uqGgex1NqrSczvxR7Qs9uVlEb5AZK1N2kjZavvxekn1
 WEgMDJT63ynJNA63A0yiOV+mqeLPEx8+DCtajcIRpRBNBHKyNySjvhPZ2mSy55qeap8T2SFHK
 B3sUs7WFvp90KC+UUIrZdbx8+8SabENZgeN/ARYinP694C3G3iPtxUyfk87mH6qtwrddrv99E
 Q2cg5yAslCa2Y2Enb1fZGZBkVFxvIGUdhcEKFS9/f/SIKQRAUd3iGEa0svNA4DPQZWjoxpsOl
 VvaHfR2wZeAWFuCncDFoEZ7wz9c6axD8v29M3bZmy4h5DoOQ00Kth6S8B61VChyLBxeB99Ixh
 RvB8yRUO2glZHRzPOHxaBCR6kyweQKRMVDN5YVn8n3U5s8OIhqc91wkkCMa1FB33KmK72VEX0
 saErM1h1mzeKHfxax8IkB7CkHS4jSkuuTt+2hy/3GR5nPyKoh2ROqX/sMRfRtYj21gXZTsQTg
 hzJq6dWEGy4E7QxypmIBujyVRN2CtszZ35/ZoNcLP6LttyQwpW1OUbzTOP831etFQ28nAJKR4
 PnmVuQAQ50YBHaeQFFDBjI0h1deyEQqs1O6+VWKBYU02pLQ3RDt+Nav8P8s/LfQx6dj5HEKul
 k/6BDnEmBNC/V6k7cuf/3MeOad9zHkt9xCfWAQ==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592595360993287886?=
X-GMAIL-MSGID: =?utf-8?q?1592595360993287886?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I've recently done some build testing on 4.14-stable and to my surprise
found only a handful of bugfixes were required to build all x86 and arm64
randconfig output without any warnings using gcc-7.2.1. I have submitted
the remaining trivial patches now, and this is the non-trivial remaining
part, where we turn off some options that are known to cause problems in
randconfig builds.

While I've carried the same patches in my randconfig test tree for a long
time, I wasn't entirely sure about my approach and never submitted them
for inclusion. Now that this is literally all that is remains, I'd like
to propose all three for inclusion.

If someone has another idea for how to address these, that's fine with
me as well, as long as we can make sure at least COMPILE_TEST is enabled
for randconfig builds by default (everything else can be derived from that
if necessary).

Note that the 4.15 release has a couple of build-time regressions that I
have sent bugfixes for but that so far have not made it in, and 4.16-rc
still has a number of other issues without patches.

       Arnd

Arnd Bergmann (3):
  Kconfig: disable PROFILE_ALL_BRANCHES for compile testing
  Kconfig: improve handling for all{rand,yes,no,}.config fragments
  Kconfig: add a default allrandom.config

 kernel/configs/allrandom.config |  6 ++++++
 kernel/trace/Kconfig            |  1 +
 scripts/kconfig/conf.c          | 27 +++++++++++++++++++--------
 3 files changed, 26 insertions(+), 8 deletions(-)
 create mode 100644 kernel/configs/allrandom.config

-- 
2.9.0
