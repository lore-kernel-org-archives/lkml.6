Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935525AbeCHNRK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 08:17:10 -0500
Received: from a.mx.secunet.com ([62.96.220.36]:33882 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752041AbeCHNRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 08:17:08 -0500
Subject: Re: [PATCH] hda: realtek: Make dock sound work on ThinkPad L570
To: Takashi Iwai <tiwai@suse.de>
CC: Hui Wang <hui.wang@canonical.com>, Jaroslav Kysela <perex@perex.cz>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <46c65214-2a41-77ce-6484-979b08fc44c1@secunet.com>
 <s5h371a913a.wl-tiwai@suse.de>
From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Organization: secunet Security Networks
Message-ID: <709f6a2b-1e3d-f7ab-17b7-eeb131e46221@secunet.com>
Date: Thu, 8 Mar 2018 14:13:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <s5h371a913a.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 4C338D8D-6404-4C8D-9CEC-960EB0CCA99D
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

yes, exactly.

First I was confused because all other Lenovo 70's devices have ALC298
inside, even L470, but not L570 with this PCI SSID.

Best regards,

Dennis


On 08.03.2018 13:57, Takashi Iwai wrote:
> On Thu, 08 Mar 2018 13:17:54 +0100,
> Dennis Wassenberg wrote:
>>
>> One version of Lenovo Thinkpad T570 did not use ALC298
>> (like other Kaby Lake devices). Instead it uses ALC292.
>> In order to make the Lenovo dock working with that codec
>> the dock quirk for ALC292 will be used.
>>
>> Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
> 
> So, although the PCI SSID appears to be a new one, this still needs
> the old quirk, not for T470 dock?  Just to be sure.
> 
> 
> thanks,
> 
> Takashi
> 
>> ---
>>  sound/pci/hda/patch_realtek.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index b9c93fa..b5d0f8c 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -6508,6 +6508,7 @@ enum {
>>  	SND_PCI_QUIRK(0x17aa, 0x2245, "Thinkpad T470", ALC298_FIXUP_TPT470_DOCK),
>>  	SND_PCI_QUIRK(0x17aa, 0x2246, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
>>  	SND_PCI_QUIRK(0x17aa, 0x2247, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
>> +	SND_PCI_QUIRK(0x17aa, 0x2249, "Thinkpad", ALC292_FIXUP_TPT460),
>>  	SND_PCI_QUIRK(0x17aa, 0x224b, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
>>  	SND_PCI_QUIRK(0x17aa, 0x224c, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
>>  	SND_PCI_QUIRK(0x17aa, 0x224d, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
>> -- 
>> 1.9.1
>>
>>
>>
