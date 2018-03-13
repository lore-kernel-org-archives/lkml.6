Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeCMH4F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 03:56:05 -0400
Received: from mout.web.de ([212.227.17.11]:51467 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751807AbeCMH4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 03:56:03 -0400
Subject: Re: [PATCH 5/5] Bluetooth: btmrvl: Use common error handling code in
 btmrvl_sdio_download_fw_w_helper()
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
 <a3f4f205-dbda-c1dc-6ca6-506d44e20615@users.sourceforge.net>
 <360E0F12-1BC1-441D-872B-8E3946EB2425@holtmann.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <bf69424e-e126-40b7-663e-c278230e6b4e@users.sourceforge.net>
Date: Tue, 13 Mar 2018 08:55:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <360E0F12-1BC1-441D-872B-8E3946EB2425@holtmann.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:8q5CrFjY5LYLpguDSkkcQcmlvQ/wZWaZ0BGiC7XRNmM8tpYg9GQ
 cm+Zs56LDLinojM1YxtXiRi+6zpa5CQh5xN4cdvu4WZZmDNQ+PFSgkT1lAJTBx8VfWDBLrS
 lGT5VJoiKu9jggwPUOU66u42z+nmDx1qWxmBWZiAy31dfJFZgSe2Pxit89Yt+h9wOXpCXMh
 uovH48CEcr09Kb8ihJirg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fbkBepypdaU=:W3nrKi58O3Tvnvtnhif9JR
 7UlBOG/vlX9ZDI+VGCthbo4+ZJTSYKoJcDRLy2gjyqnalaWRY4shlmSjUy+5uErZ9DKyOrqmT
 0U6SykMYz/d7GcVjy4QQsZIi83cQPrHoucfTw4zSMoadivxeQGEPQB35Pde6AOukbUSbwIpGZ
 z0TGa8jD7KsyfCpYgWbG+o3gIRAqQFQpgneVTlwL94j6pBNxrscnvKBtI80byYdDhT9HqOc5+
 JTazFoZct5OOxWuqdH4XjAoULfShgYETJ2fE29uEwOne8HyJi25wM9Yk9jLnvaBZbRBTOKlnq
 e1DIO659WQYKVWGn0UXSA6FUIt4Da43K4KMUKIoVQqPZW3WAeXbZGDREm+6yGyAr1GyI9XffB
 WYE7dwXMychY+yLysWX7lCwMD4iUK2ZTLaOA3oRrQQTirXu9DaTXuwKcxGsQUgVvf0j33ws15
 jvK09XdLdwLreEmp7tasv4TqIsrEEGoxU0R2K0fmpfs064fCxLZGu3m0Yqp/i0LeZZyWl6LXa
 KC2lYcYyKzfF0QmbRL3aFnVS3ALMUjoOWEERhPb5g3oUXNiOBaSOnfMwj4S8g9JJeMThuz44I
 RUvxsE9odu3MozSOX6IJUNwDxst9obdOGa7jzDggKdvMOcQv7xfY7GiB15+bMfzlIQfhV4Lu8
 GCQvvHQLfj95MGanjxmx79iIEWZL21C9fuY4URqcuHdGyFu/zdbBmbCnVhpswH/dQV88YUW8l
 0RbjYw5AoS+6Obm+cNtLvujr7BgKQtAYwvWrKWsTDSSz64G8kadH2ydHm3vDiU5KrVRlT2744
 av9o1DsJq6mH3XoJnLALqwfzfKfzzIetNEZBu0ALV5rFsJyMPc=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Add a jump target so that the setting of a specific error code is stored
>> only once at the end of this function.
>>
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>> ---
>> drivers/bluetooth/btmrvl_sdio.c | 13 +++++++------
>> 1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
>> index 05c78fcc13ff..24ed62fe2aeb 100644
>> --- a/drivers/bluetooth/btmrvl_sdio.c
>> +++ b/drivers/bluetooth/btmrvl_sdio.c
>> @@ -601,8 +601,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
>> 					" base0 = 0x%04X(%d)."
>> 					" Terminating download",
>> 					base0, base0);
>> -				ret = -EIO;
>> -				goto done;
>> +				goto e_io;
>> 			}
>> 			base1 = sdio_readb(card->func,
>> 					card->reg->sq_read_base_addr_a1, &ret);
>> @@ -611,8 +610,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
>> 					" base1 = 0x%04X(%d)."
>> 					" Terminating download",
>> 					base1, base1);
>> -				ret = -EIO;
>> -				goto done;
>> +				goto e_io;
>> 			}
>>
>> 			len = (((u16) base1) << 8) | base0;
>> @@ -638,8 +636,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
>> 			if (count > MAX_WRITE_IOMEM_RETRY) {
>> 				BT_ERR("FW download failure @%d, "
>> 					"over max retry count", offset);
>> -				ret = -EIO;
>> -				goto done;
>> +				goto e_io;
>> 			}
>> 			BT_ERR("FW CRC error indicated by the helper: "
>> 				"len = 0x%04X, txlen = %d", len, txlen);
>> @@ -681,6 +678,10 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
>> 	kfree(tmpfwbuf);
>> 	release_firmware(fw_firmware);
>> 	return ret;
>> +
>> +e_io:
>> +	ret = -EIO;
>> +	goto done;
>> }
> 
> I am not applying this one. I see zero benefit in this change.

Would you care for a bit of object code reduction in this function implementation.


> It is not even saving a single line since it actually is more code.

Should I fiddle with any other source code layout?

Do you find an extra blank line inappropriate before the added jump target
in this use case?

Regards,
Markus
