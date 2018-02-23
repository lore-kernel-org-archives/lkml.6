Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbeBWL4B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 06:56:01 -0500
Received: from mout.web.de ([212.227.17.11]:44175 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751276AbeBWLz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 06:55:59 -0500
Subject: Re: [0/8] target-iSCSI: Adjustments for several function
 implementations
To: Dan Carpenter <dan.carpenter@oracle.com>, target-devel@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
References: <6163538d-a406-2f60-11a2-88b4694e9975@users.sourceforge.net>
 <c9a822a4-248e-c479-9118-4b8ffb1033b1@users.sourceforge.net>
 <20180222143624.7c7241a1@suse.de> <20180222135600.5vv7vzw7sa5metcb@mwanda>
 <145b88b1-bd1e-a417-8dce-ff19e35a00fc@users.sourceforge.net>
 <20180223101715.xv5dscdaeszqxoyk@mwanda>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <866a1802-0cd8-48fd-e04f-7dc676ab58a6@users.sourceforge.net>
Date: Fri, 23 Feb 2018 12:50:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223101715.xv5dscdaeszqxoyk@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:swOsVOYe4UnbjJkb/PFOslKGU753oF4pUbz71+hn31PyN1oet50
 HBV8+UtOlxW9d7bx3PDH1Ss33h3cGYxR3umPCFq1WrFzixeaWIEUx3zJ7qZr878TPnoMsoh
 4oVhTZpE7HbtsHyhldQTsiYv56XGQkIX1GE1ZxSztBTLDIElu1Rw5ms1FxaOxvw0bkfyyyh
 eo0OTTBzJyGc1uWjjJ+ZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kgB0zsviVaM=:RoB9I7REcD/hoKEZBguP+t
 W/vIgtm+HbK3s2bHqYYQcf2p4wy7Wmu4x5LtsYZK5UJgZg25IvZvNnnMmui+FZq+ksuz4ZvY6
 MZBxLBL/mPZdu9yOZZ4VC9jR3EH27E5phazZSSS4QS2uyWfP/H6gneCQvHbRFy+oNmjSqXnE3
 xKU9cAObiGKUpeRW7RSbTA1Ew8/a5ZXwNYyL+ViGalVVFRLUUg5wuQAhVml/d2A0XvFSA/CP2
 3uF/kKvGSHNv3Fzo2niKq3/SpQJc0Y+7JJ5CqyQJOvIcmjDYpiwAUPyjg/zVuO88qBNz71Tyi
 CR+5mkhnMaWFiRPk/pOtQvvBCZrngk/HXYnCIBCYzuvFMNG33nNrPof3WriY+tf4+u6jaryWc
 JCazfch2NB1QvsyJU0A2BwyzwIrYRKJsAYsy2p/Ekq4OoSsk7c8Vacx6WyypDpRDPlpyujRaC
 H0ex8gacCkT4is3lInfCik9x+bRquaSEWSfFpU9R5JDooDNYGqgEJ7d3s19O76LNdBG2rIBpQ
 scEkmTiKIasbjo61/85FziwK8wD8n3PnrSJPuAKl5XlbkMXd2Jhjxry4XN51+lBCKdoUA2NMm
 Qlg6I98vmQGea8shlWcx1brFqWZlbDSGI/RbAAdu+o3AXBdov4yhUabVbJgrY7K9c+/kgvTLQ
 mT2m1OSN+wRZAZVieMwRVIqln7xMbwV8OHE/5DikiMStp0Mi1lKMQg7fMhfD5xO2Rhj1Ml4yK
 DJR8UDUElxFxK1d7WEnQDvgBbHClQeoslMd51RYHDboB69+XHafzipU4H9Vo+KarM4CTwR8hW
 rVsRIhojMzMga21rpf8LFpRB9Nf9E0qzc6RaOhRc3jkdyPfv7o=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Can a passed null pointer really work in this function?
>>
>> https://elixir.bootlin.com/linux/v4.16-rc2/source/include/crypto/hash.h#L684
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/crypto/hash.h?id=0f9da844d87796ac31b04e81ee95e155e9043132#n751
>>
>> static inline struct crypto_tfm *crypto_shash_tfm(struct crypto_shash *tfm)
>> {
>> 	return &tfm->base;
>> }
> 
> Yes.  It's not a dereference,

Do any processors treat the zero address still special there?


> it's just doing pointer math to get the address.

Can eventually happen anything unexpected?


Can it be nicer to avoid such a software behaviour concern generally
just by adjusting a few jump labels (as I proposed it)?

Regards,
Markus
