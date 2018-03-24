Return-Path: <elfring@users.sourceforge.net>
X-Google-Smtp-Source: AG47ELvVn6bJxfo+GCzlzTL4GZY3NDTXYyB3CSslBX5+NtiNYB+hQvMUsAPiCcFfOc25YYKT5shZ
ARC-Seal: i=1; a=rsa-sha256; t=1521882520; cv=none;
        d=google.com; s=arc-20160816;
        b=R2pDQWW0/HYKV9CW6zsF/Y3DAQgbp4vTHfuTwqjMDsialpZw553hUYPuHaXP/fPMtV
         IBTTuNs8DdwcIl8I2JJ9SQBnjI0MnNYVbpzu574st3JFd/ebiAq1hShme7PgUeK80Csa
         iwLP4Tx5rdTd+jdlTcqP28hNPq7Yf3bJzChHeXN6tLUCvI0KrR8O4VOMBP03G9kVFD9V
         yj/Rjui8SLQH0GU7Ke7CNZSVT69ayBBYr33WCJgWy95DBsIFUAeOaEKb1tTCzJrwR/zv
         LuXxiAXpKz66Qx129Xv+3llptjszVlOobPl4KYrEiTGRvdK//SjvGQOHKkepq9qI5XBZ
         KzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=xCzBhfx9pKE2vOje5jChCWcPZA5s1L6wwwcRGKSo2iM=;
        b=VqXobrQflVBzvc3ldIwr9tH8Qzbas7KxgBtzpAjfsP2ZjjmfI5wTdGntryNIcBcz1u
         iQHVyo432C309D2SJ+3CS+hV11BEfomy4hP/2hON1tUFlrdb2SCl6V9kpYeCxMWNiuUB
         h9LR2SplcZbElpRgKYVvROlJXDq2az16vjC/wMSh+sksMX/Z0f7pBvJLVprkYY4uaGOQ
         RYksiWD+4vfL12ExSCQ5y8nGN2CEkurqnY/wGdi3s7i/slt8VJdLoi4x5yai0pf61v5u
         zQxZcBeWJ4dcbsrQxeQa4KZR+zhoIfWyD0GSMdp1lCUphx4+rW+VGXlZb6gTfOm4F+Ts
         SjDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 217.72.192.78 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=sourceforge.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 217.72.192.78 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
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
Message-ID: <7faecfbc-0fea-b262-a81e-578615358081@users.sourceforge.net>
Date: Sat, 24 Mar 2018 10:08:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180318101506.460f3967@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:27tg7BZeTS/ti/HCmUkE2GmcGUY1F6VmEAORDfrKyXM/IG2d1gZ
 Wa5MQY23Hs0Uxm9n/+CUkRIQv51aZFDmuPUfH/eGgsTVxodNUNBuDzXqznRnQ71rAowine+
 wkdLAUFSbte96f6R9fLwu5JS+v/UiRrXhyQqhQtFZTJgoE7zgw9yxd2prMIXIkUnVmICiRl
 rt0F5xJVoBogOl060eJYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WJZ7peOpdcE=:i0j5S0KogZSyzwojO9MvEL
 DUoAm3geilSKWUhnMxXc1MiuwpCPOIh7R2vkwFrN1qTrJr48C92CyprF1dNRb1a3o89AOoRJm
 zmaMETnDMCY2qmyEwWLl63uZIQqXcwE+E4QWcmivZBMr0UwF1EUj+ST16B56zX5EAV7vfHQ9s
 r7mRp2AhBHkNIM7hL8YZ/hN/2HItcceUPQ7kTdagsrE0HIzMDUg+2TGmJyhkovX+ca1HchJRw
 jCsZUqptTRjlFyYj8ywPEfIH3jEOgCMAxp1lpb9iNY5rTqoE8/L6Dd3tuXGpdTgKmzD0vz6Co
 M83B3msBdMGHi2Jbs8HDkQVrFHcrSnPXDVvvHqT+OJLzrmnWYqM2WhzT2rAQBM5l4S7COnBEl
 T8f0CBp9Dea3v+xD0K5WzDZ1NOxpdYFLm4H7EjWXr/jeZyp7j40oDizLdbXpKPYRxG5OBxkmH
 KC+lyCeH3m3wL7innCxq/qZMYxOl2ERN0vpLaFlRrQu2ebUqdkE5Ax8vYn5oujrMAH/YBzRz9
 RHAfJ1Q1MWS5hgslECTCdfcC29IZQ7dw+Fu6NbL2MIRZnN9fxM1THrUuXCJ1mrnV5QD2qkwek
 ppKUnoDEPU518uorg4bBOhG0jPCCPxinDcSJEshRJAfALK2v9lzU7EEEBgXD3jCGHM4C8E9f7
 Wlp6I7dD7qv2XPNZ1xsVPj1a2cxpvV7cPYEZ7oN92K7meoaFHGiap6Pqxq+k92TtPYVTSbAnu
 WYojEM3XsET73FXMSeeOw6uKoI51nyAO9uGNSU1biS6VcOzkbTvwiNY2ehSzxZx6DBPKy4zjG
 k72UK3mt3W9PEqh4Rb+GhC0t8jsvaAi4BhOZUnQDdseE6Rkkuo=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594926606648991207?=
X-GMAIL-MSGID: =?utf-8?q?1595809485643383562?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>> The mutex was (and is still only) locked within case branches, isn't it?
>>
> You are correct, this does however reflect the issue with the resulting
> lack of balance here.

Do you find changes for the other function implementations easier to integrate?

Regards,
Markus
