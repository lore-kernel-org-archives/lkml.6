Return-Path: <elfring@users.sourceforge.net>
X-Google-Smtp-Source: AG47ELuR4jDrQqBAbaYVdoR302sqbRF47gGtle0F6R7uPNTbbzQrbPIQcnYcyRiqBvWEYQnULajZ
ARC-Seal: i=1; a=rsa-sha256; t=1521453117; cv=none;
        d=google.com; s=arc-20160816;
        b=At7NVj+jhZHt91vlOu8Er5g6jG62N4Oke++LD4WS5GJNhUGlU3kMKv3oRSKN1pRMyC
         cKEgwRYotoePTPqbNtf6doNNljgjV32SRwYQmN10JzyIplHyC5r0mUuZP/lsAWCVZwhY
         bU6Q1XzxrOYPbbYyc320s1GJutYew1qqLQuckeMrSEYQsckCOFmhWtGSEHsTz3bga3vE
         sJxKcNxgA1WOtBHAl9ua02QhGhdGU5cQ1COG/NIWTdfwsx4FLQSrIIVbs3BK99FczwvD
         fuvU6K9S+YzHpT2RgCHJh7pfEO8f+PkjNPbcUNu7lHsrK+6c6qUbRIyEyNhyfFcKaFXr
         /Giw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=okPrt69TxKtQznFCRQkCZCA16ZHGrWMhXUAsIEyOStk=;
        b=Fjlaxxac1M8C5JkNDumyWeYRCCe0O2oN9ZGRXLvYC+RptFHweQrL6fXbIZ0qXFo2qE
         ZhePPAIsMg04AR4iMcYrvkVsYuJKgf/EGUsScyjBo/PtUkXWHEsUhiCExRFL1X3qbqIz
         u0rGGULJVdmgQZI6c3IFNNl5wWrNTn+/ICSS4X1vQWVlTifNUqpUUV5mRSWO12WVXc3K
         QiJqb1uofWvSVAt9n3Fei8yA1FyRy6VDCe6pKYQ6NBwRiTToQWB+AnCiolEBpQstyLJy
         DZG03kdBWDo4fXF5yedz1fxLdkLQEl6FTM4ttYH3PkCb7OidYJNDSGUZjGit17sHD5qf
         bVqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 212.227.17.11 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=sourceforge.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 212.227.17.11 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=sourceforge.net
Subject: Re: iio/gyro/bmg160_core: Improve unlocking of a mutex in five
 functions
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Pravin Shedge <pravin.shedge4linux@gmail.com>,
 Quentin Schulz <quentin.schulz@free-electrons.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <16623de4-351d-135b-f3ff-701a465c5d92@users.sourceforge.net>
 <20180317195422.037a8b57@archlinux>
 <73f0a187-57d1-c877-ba9f-3b15f6a61640@users.sourceforge.net>
 <20180318101506.460f3967@archlinux>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <4f0c5eb0-e7c2-9c27-387a-e62b19f0578a@users.sourceforge.net>
Date: Mon, 19 Mar 2018 10:51:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180318101506.460f3967@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:olI4GfvbaxpM0yEkNh3MjnpHzJFmtoqItMLvgTNyOEozYKYdfr7
 h309JKpdwXMcI1mMZEfOOcBmD7Nx6IUHf1UG6mP9e/wY2q/469gMsLHicxf9+Bbdk/QwDx8
 zOOjymy2SFc0BR5mJz3EJgg9j/LOTMWgupT1QmDCrQZ1VQwBbrHNddqy47IDc5PuVHATbv8
 ZeStsaGMCn/ijP2AHmXew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Hl3MLvA8Dbw=:HLlLGcewQ1BKQSpleq3w1m
 MnyLdc7oguSLIcQTLp/mWeXnfHUf/QDVYslxTpYzATPBuxbl6o5d/Amx8Co4u3YniAX9of+z3
 78jtwQ9VSTXMaju7MUcXXb1VFzA9X1eVPsTPduY3PeQEeTSYERL/4hWBhAmKO+TEDtxEmybv7
 +AeeDH66EsLiZ0g5v6QxrhVMJRwdkwNsT5xuIkbG5/4ehWCYkqYdUEJW9JVbChu0hQycSzftA
 NImAubTT7JWsqNZtr5Nn0wlej0pur/EKm8pvtCtX+sKci4eTBd+b2Qteuhb6A87qgetXfITSa
 9YCbd35lrKqVDAwz824MI0MzVi1pq0/EMnKx2Iz36ZsBK7mwhGbrtHeZvBAWhQOrSVmEF53Fa
 tz98bcclPcep6QCzR5iyFnMimx+62mkl0KQSMrlb0bztCEqQdgbsVW0ogg2DkS14BXIr+AL1A
 dWG8YHkJWwiWihZ3VUQtiAcPeg5YLz1fnGzV5B15LMOe1ukFXZ5eanYgWhlw7lsmiZzU+VDTS
 jf942OUAmXQrVQQ+Seg+NAC+84ocX1G2ePHB/0NyWs/s8ExjWTybLRU841wLJJMBuBaU8oIvc
 c9jA47pyiYIMiew/fXB+x3ExiLOnZAcvGYIYA7BF5C5YUjC07XIgInPJpISG6n+wjLV7APL5c
 xVfHF9jG4hsAt0eRjjUSUoJwIl5slyNJtvF9XsEs5WBwlBDeisrcUpXXPRTRbG0YrOHQjHPO0
 f+68QYwfdiSrhs5yK/6dJmT4KsyELHVD6Y/WaYJUWPmCDUiEFFEY0acISlmDWD7BmvJv1xPcO
 FD7Qto0nzoQadsJ2uJ2q4xl8K1r9wQ8aSVBIoUM/HFCuoWnyc4=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594926606648991207?=
X-GMAIL-MSGID: =?utf-8?q?1595359223603488016?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>> The mutex was (and is still only) locked within case branches, isn't it?
>>
> You are correct, this does however reflect the issue with the resulting
> lack of balance here.

I suggest to reconsider affected software aspects a bit more.


> I saw the mutex was getting unlocked outside the local scope and so assumed
> that it was also take outside the local scope.

Assumptions and corresponding expectations might need further clarifications.


> That isn't true, so we have hurt readability.

Does your conclusion need any adjustment?


> I read it quickly and got the wrong idea which generally implies it is not
> as clear as we would like.
> 
> Hence this change isn't going anywhere I'm afraid.

I imagine that more time will be needed then to get used to additional adjustments
of implementation details in these functions.

Regards,
Markus
