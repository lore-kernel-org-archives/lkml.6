Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeCXJBd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 05:01:33 -0400
Received: from mout.web.de ([212.227.17.11]:54411 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751719AbeCXJBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 05:01:30 -0400
Subject: Re: [2/4] scsi: hpsa: Less function calls in
 hpsa_big_passthru_ioctl() after error detection
To: Don Brace <don.brace@microsemi.com>, linux-scsi@vger.kernel.org,
        esc.storagedev@microsemi.com
Cc: "James E. J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <f013341a-e3b2-69a7-4918-8bb3d109f0cc@users.sourceforge.net>
 <e53f792c-0062-1b7a-a914-fa5f62b9a5c9@users.sourceforge.net>
 <1dc030776c924626b97594a18537f59c@microsemi.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <a1e4dcf0-22fa-0b9b-a111-56beac441b24@users.sourceforge.net>
Date: Sat, 24 Mar 2018 10:01:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1dc030776c924626b97594a18537f59c@microsemi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:JXq1YYqHJcWcQDszYuXwndo32NRbCGY11orQyPJBbMoNzhhjBBN
 PDNZM7Y3F1FjUqii9Ekuf4LucAXIFTyqqmnGhHV58pYz64yDii4DyiEGMPuYS08MQkbffZP
 anXLZD0VMr39bwz+Ae0fdHk46GOLciFi2cG2kape/6+iurWOii/KgA8w4ZIgnJF7NVTZY5S
 f+dC2IP84QNOmTI2eDcog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6yWm7AV5n9U=:4vF3rgW/by2RX3oXKpQOtz
 fLq5HJ3MPiDz+AzMgaq7uzLlriC0cUwxvhuCZYRj7C3cXYPfeipYxTyK4EtckPPqRK+YdHClF
 m2X5o+jABKCyj/D8zVblnV/MoZ1clEzVHXWv+stdglyUcTjuqRNWli9WR0SzHrmm3VVws5yRI
 vLQv8n/hIvi6ZTZTwZeQ6hiodSOou4n2SHh4no6K0uLhgQco35q/wea2120Oq8gvLZFtSHfMc
 +hC6G0mYyMLPou+buDdUK3cOnN9B+y5k1uqIip0XWqUWJj8BOwkCKcBtHmgu5b24EWWgvPox+
 tH8Ev8u6eVM/I8Tm6F9rbkqw0lJDei6L/EISVM4TsM1NWeuhybKBuKUqcaludy77R3nwtbVN5
 Vs9sQwT62iqTDJgDYrx1D/r+6eJKfX5gO8h5PoO27MMsz0VRCbV0SJIAblSTC+JST0rP1G9bQ
 9ctCCX1Kmqpour8xETqSZYy6gJTurZLoNeGptlZy6+dugmBcgHmtYEdtQCkvsK8sIB5bEtYK+
 HhGJZwXuKFj+B/n6sRvsu+9Wy+c5O8BDd13pTzXjfxZAyAm7GMUpHUbNL3pWpmC8louWVcd/K
 7lJu9ttvPfJ2Rb9rDgpDpUPVAAjXpUbF50Edon3QPC83q0b/nWZTZTLKKEVQERCMM3xrV4lL/
 3vDyLPc1ewqSGBdCIiNfW0Re3rY5RD3OxWUNP5EHufVO/ijQEy2DbbvMyWVyzwUH6vpeVfxtz
 5/A0KXmp9CaRolDquQDoDcRNqZM5WZWllyFYV52UoZB+9zIndLdUoL15uFsspeI8L4Y7YWtR3
 ZvRyNNTzeR0rOXuD4wifNTROSPD3pmREs6uMR1bXcGfIFvezKU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> @@ -6501,14 +6501,16 @@ static int hpsa_big_passthru_ioctl(struct ctlr_info
>> *h, void __user *argp)
>>  cleanup0:
>>         cmd_free(h, c);
>>  cleanup1:
>> -       if (buff) {
>> +       {
>>                 int i;
>>
>>                 for (i = 0; i < sg_used; i++)
>>                         kfree(buff[i]);
>>                 kfree(buff);
>>         }
> 
> Thanks for looking at the hpsa driver.
> 
> This HUNK ends up with an unnamed block.

Which identifier would you like to use there?


> I would prefer to not have it structured like this.

Would you like to show a source code layout alternative?

Regards,
Markus
