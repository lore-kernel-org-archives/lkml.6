Return-Path: <grygorii.strashko@ti.com>
X-Google-Smtp-Source: AG47ELsT/Nn4crj7TFzi6WpRqawnm4MVWRLDxEkyPIarWzLGU69hXFY+snxBLlCG1Pg+Jfxp5rBC
ARC-Seal: i=1; a=rsa-sha256; t=1521238135; cv=none;
        d=google.com; s=arc-20160816;
        b=jj5s8BvIByUvRDyKO9VDwhkYJP4F3hvToc8YklvhNv5mPWqk5tMT0arK5O6IKtcaIk
         2KOZmg1Lu8I65z5M0sYyRV9I8rfHnZBkWFRkNDw6v5d6Kp94Bdsdz/iBRpMkdewjwYoC
         xJoLyBUE5B33zDTBBKZ0yMuL+f+ulMG3ufVrFJAEdu93tlo0+KjGOJt9hA7WTfLWMhw6
         1IW7oVCcFaMT66G/sBVYvKhO3s34i3jPpjB4sgUM07Ca47TTUX27QIyYEpsPTO1THLIH
         zgWkO9jnbNR0W1hqHdp/zO5I6n0dJy2TCEkqi7XbbyJga2GwqlgZPIKTnLUl/PbqOvUl
         /D8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=H8cREc1Rx2DtRX43ThkP3a30Zun8gwC425D2SVG1njU=;
        b=RydyF8BzoA/gqPHHTkzLOVfUzFlmRwZJGC5tHhBCQF9Jd75FKyxrW+f6Hu0ZRIXzNO
         BEacABOlfjAKOexG/1KgX1HRIJGxO8JbnTvN6cBwnzf3ZRhbjMeBVisKUdj963oqc4sA
         8XM87rXlx02jWrPuENoLeEs2W/b6ck2s9yMKgGlhRjPbqULVjQx5PSIJiauEctmqxGBG
         AClOrIDED1K8JF2ILCMCwblsk2UGJA9x5sW7PFG7oKJeJcNtXFljuCoj/ijUeFeL1cp9
         JvXKHs+KjUe4hxqXhphdP+NaVpvuGYkvGALem8vc/jPj2ftdIiK5I5E9YkBfYP9Cn1NL
         lwkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=P+A0SUy8;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=P+A0SUy8;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH 0/2] net: phy: relax error checking when creating sysfs
 link netdev->phydev
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
References: <20180314222624.12744-1-grygorii.strashko@ti.com>
 <20180316172234.GA4212@lunn.ch>
 <72ff074d-b19d-6ae5-59c9-4aacaa8070fd@gmail.com>
 <e28f0101-cf3e-58f0-82f3-7e45bbe4bf74@ti.com>
 <44DFE938-3FF8-4608-87DD-BC84705EFFF8@gmail.com>
 <f9f7ea0b-4e23-d837-c1b1-73ed7d6fb686@ti.com> <20180316195403.GA8735@lunn.ch>
 <0daaae50-ddb9-8a94-d4a7-02861f0a6eb7@ti.com>
 <c790757c-0b4f-575b-1f6a-5f870f840e20@gmail.com>
 <20180316211459.GC8735@lunn.ch>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <1878e3ee-fd85-b42f-dfd6-b52e8d2216bc@ti.com>
Date: Fri, 16 Mar 2018 17:08:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316211459.GC8735@lunn.ch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594953711945737346?=
X-GMAIL-MSGID: =?utf-8?q?1595133799273144552?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/16/2018 04:14 PM, Andrew Lunn wrote:
>> I agree, let's not have you run into circles, let's just use your
>> patches as they are since they fix the problem and are not intrusive in
>> any way.
> 
> Agreed, this is too complex, for little gain.
> 

Thanks. v2 posted.

-- 
regards,
-grygorii
