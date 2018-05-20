Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AB8JxZppzlSNAmDQoCq39Sgo93t2Er8Sff4PQrsBxel0qchRJ2UeMOOWIqwUDSR+/3igodLqP+cJ
ARC-Seal: i=1; a=rsa-sha256; t=1526804533; cv=none;
        d=google.com; s=arc-20160816;
        b=fy1BfmAyD3Hhz63Jmpm8Koy6w3/eeKxKU7nIj/c1MYSFzhxB2dm4ojM5GZUv3pwNrl
         vd/5e2yJO7C7x9179nJB6MtaCT+DzSHnj/UB/JwGPv2DTUUJnmSDc3Medb0vU1DkX6Yc
         iugu7rpS/b75MgZVQ3/+MtN+CBS1zgZrW0CaxyDtKlmTQKRCxecG8IlEdLo6H2v+P1jI
         i5D2gdBtCdXQxV6PfsqzbHo6itEzi1ynM7eKmfmYZiCiZM3SBUessFyUKs0+/BmKtqu4
         xQn+NiEEQ48fChoerr85+AklL5DjdG7AszHCgAFUVIUIfRl+xSMen7SLsoARls+v/Eln
         4DeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=qFT1J258w6L/Gtc57DOwdtplxPl7Q6HmLU1RnDchM98=;
        b=N6r0J7flNmFbjyG9maODsU1vDLt7Q1WcdyJzwgkoOspQcT3vShB8UaqItdZgXxL7aR
         6qFHKTWVLaM1HN47U40yadRoP7nLVHt1/bmO4JV3qCmwJ8TUhW0L4ULMQ2EizPeave5a
         X6Ra03pvW+6TA0yjXJPRWWN2uZliBbUZSeBn0GPvOdPBfW8lqhhVvI4FT4ER0LZrCXQs
         IniV0A4Cv0mu5C4oirpU/Sa2CihhK/UZFedFzi9IPMUBuaXpyt87xDLyn1vYcasDt5Kw
         AH0H4j6uIRNb6X8lLuqNzoKqrYLCMFpVCNWM+cOX5nNwFxWLVCVH1ORtSPSIvI+MeGFu
         7jUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=q0R3x19V;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.80 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=q0R3x19V;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.80 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w4K8Lvec015225
X-Nifty-SrcIP: [209.85.213.42]
MIME-Version: 1.0
In-Reply-To: <1e943db9-1340-2a23-be43-2bde85e3535b@infradead.org>
References: <1526619146-1895-1-git-send-email-yamada.masahiro@socionext.com>
 <1526619146-1895-5-git-send-email-yamada.masahiro@socionext.com> <1e943db9-1340-2a23-be43-2bde85e3535b@infradead.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 20 May 2018 17:21:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ7p7TD2_qVCbdAjLKjpYYoaDWx-73Xqba__Ub6zwsJcQ@mail.gmail.com>
Message-ID: <CAK7LNAQ7p7TD2_qVCbdAjLKjpYYoaDWx-73Xqba__Ub6zwsJcQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] kconfig: refactor ncurses package checks for building mconf
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arvind Prasanna <arvindprasanna@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600776240586808874?=
X-GMAIL-MSGID: =?utf-8?q?1600970589938348757?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-05-20 3:02 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> On 05/17/18 21:52, Masahiro Yamada wrote:
>> The mconf (or its infrastructure, lxdiaglog) depends on ncurses.
>> check-lxdialog.sh has additional checks in case pkg-config is not
>> available.  However, qconf and gconf already rely on pkg-config to
>> check necessary packages.  For simplification, drop the fallback
>> code from check-lxdialog.sh and move/rename to mconf-cfg.sh to
>> make it work in the same way as the other GUI frontends.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Hi,
>
> I began by testing "make menuconfig" first and immediately got this:
>
> *
> * Unable to find the ncurses.
> * Install ncurses (ncurses-devel or libncurses-dev
> * depending on your distribution)
> *
>
> I do have ncurses-devel installed.  However, it seems that
> pkg-config on openSUSE is not very reliable.  zypper (package management
> tool) says:


Oh, this is unfortunate.

I was eager to use pkg-config only,
but I do not want to cause troubles.

Could you check v2, please?



-- 
Best Regards
Masahiro Yamada
