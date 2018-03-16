Return-Path: <grygorii.strashko@ti.com>
X-Google-Smtp-Source: AG47ELt9F9RA/u741c5Oq8gckq7nCGNydcaf+0yYsb2S5kosAXaTJ83bXORUh/CcvkhQeHh+H7Mv
ARC-Seal: i=1; a=rsa-sha256; t=1521229313; cv=none;
        d=google.com; s=arc-20160816;
        b=SY+OOM9ORFsB4QDKSpeMJJi8y0b9fKq1mjgoz+FrE/W+51R3lm6A6XntoSrnlvMx6+
         EsalGm7mj24F4xefsii6smB6Bth36jJylKckRPkE8XB9SvjzNwIlsE3yNN7ZTwh0oT9Q
         EKyZbX+PxABfC3VtkvaqDBK9/rIYdTF3MY/tmmVHP1miLm15YwEL8I0tBypBJ+lSLsQc
         qJzGQFpze6qF1Rdk4UvUg4sQxtaEXKmOkhcN7DCAIFLUkMopdhk7K2NsInuz1ZbuTqn9
         ycL+LThOJ83ftSO8J2Bqh8vFvfsaxv5c+Xvxx7YXuKBUhJNELXU66avNHxrK5Dq0kS1o
         6BRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=2OGXjx5MW6FYyGQnu8MbsP6whq2OPHmaW77RH+6pyi0=;
        b=lTdlIoHujlK+PfYEjjapXYet4ZTnivKn9yRvBCyO0ZqpOQtdm7UFjyafWahsZdY9Iz
         zqYT1b5okKV/qTfoAtNWJWY96GmW1AI/rXWqup7D6sY20jMKwtF+bd3uAT5aAN/4WrPZ
         TO441godAw4f5dOuh1n5wF9sfPA5AI1860FO/JiBaJEofOi7uwRsXQCtJ956qNElo3KS
         lFkpTvnzD1GBQ/4NPDfTuj3/ssS24jv7rTr69irn11I747M+WT0OS8yqmqGF4jUoeqFy
         4YCfo/XdesMjs2jYRaI7mr2dDFTaIVq3dkxFFwVXEBmaOHtUdnDGo64Bfws2IwVOc9Z9
         Kygw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=jQjPyOXk;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=jQjPyOXk;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH 0/2] net: phy: relax error checking when creating sysfs
 link netdev->phydev
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>
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
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <f9f7ea0b-4e23-d837-c1b1-73ed7d6fb686@ti.com>
Date: Fri, 16 Mar 2018 14:41:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <44DFE938-3FF8-4608-87DD-BC84705EFFF8@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594953711945737346?=
X-GMAIL-MSGID: =?utf-8?q?1595124548268392864?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/16/2018 02:11 PM, Florian Fainelli wrote:
> On March 16, 2018 11:42:21 AM PDT, Grygorii Strashko <grygorii.strashko@ti.com> wrote:
>>
>>
>> On 03/16/2018 12:34 PM, Florian Fainelli wrote:
>>>
>>>
>>> On 03/16/2018 10:22 AM, Andrew Lunn wrote:
>>>> On Wed, Mar 14, 2018 at 05:26:22PM -0500, Grygorii Strashko wrote:
>>>>> Some ethernet drivers (like TI CPSW) may connect and manage >1 Net
>> PHYs per
>>>>> one netdevice, as result such drivers will produce warning during
>> system
>>>>> boot and fail to connect second phy to netdevice when PHYLIB
>> framework
>>>>> will try to create sysfs link netdev->phydev for second PHY
>>>>> in phy_attach_direct(), because sysfs link with the same name has
>> been
>>>>> created already for the first PHY.
>>>>> As result, second CPSW external port will became unusable.
>>>>> This issue was introduced by commits:
>>>>> 5568363f0cb3 ("net: phy: Create sysfs reciprocal links for
>> attached_dev/phydev"
>>>>> a3995460491d ("net: phy: Relax error checking on
>> sysfs_create_link()"
>>>>
>>>> I wonder if it would be better to add a flag to the phydev that
>>>> indicates it is the second PHY connected to a MAC? Add a bit to
>>>> phydrv->mdiodrv.flags. If that bit is set, don't create the sysfs
>>>> file.
>>>
>>> We could indeed do that, I am fine with Grygorii's approach though in
>>> making the creation more silent and non fatal.
>>
>> The link phydev->netdev still can be created. And failure to create
>> links
>> is non fatal error in my opinion.
> 
> They should not be fatal I agree, but it's nice to know when you are doing something wrong anyway.
> 
>>
>>>
>>>>
>>>> For 99% of MAC drivers, having two PHYs is an error, so we want to
>> aid
>>>> debug by reporting the sysfs error.
>>> That is true, either way is fine with me, really.
>>>
>>
>> Error still will be reported, just not warning and it will be
>> non-fatal.
>> So, with this patch set it will be possible now to continue boot (NFS
>> for example),
>> connect to the system and gather logs.
> 
> The point Andrew is trying to make is that you address one particular failure in the PHY creation path when using >
 1 PHY devices with a network device. Using a flag would easily allow us to be more future proof with other parts of PHYLIB
  for your particular use case if that becomes necessary. This gives you less incentive to fix this use case though.
> 

That's true, I'm fixing use case with >1 and I'll try to re-implement using flag as requested.
But note, this patch in its current form fixes 1:1 (phydev:netdev) use case also (at least as i understand it),
because current code will just kill net connection if create sysfs link fails, so in case of net boot -
failure logs will not be accessible without direct access to the device.

Actually, how can i pass this flag "<name of the flag>" from CPSW to of_phy_connect()->phy_attach_direct()?
The parameter "flags" == phy_device->dev_flags is used to pass PHY driver's specific options, so can't be used.

The phydrv->mdiodrv.flags can be accessible only after call to of_phy_connect()/phy_connect(), 
but sysfs links are created inside these functions.

Thanks.
-- 
regards,
-grygorii
