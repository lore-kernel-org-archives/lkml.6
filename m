Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753006AbeD2JoU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 05:44:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:48761 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751930AbeD2JoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 05:44:18 -0400
Subject: Re: [PATCH] md: fix two problems with setting the "re-add" device
 state.
To: NeilBrown <neilb@suse.com>, Shaohua Li <shli@kernel.org>
Cc: Linux RAID Mailing List <linux-raid@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <87efj2mv6i.fsf@notabene.neil.brown.name>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=rgoldwyn@suse.de; prefer-encrypt=mutual; keydata=
 xsDiBEaI9tIRBAC+jCQxwxm9mPCrzNiUskTzyLKUPLdW4n8Rjmt/N4ISt0AZWDKq7SpiDQjr
 yfOORLFFBFsfSH40OJlBjIpO+mh9XHPbc83bOESJdT5huIbC/0yuqR0xYVt+U0FLXQJ3w70N
 9eALGVxPPcQ3uIBpdTJUqkvKf9x3xLUdqRe/GQnXcwCgjKJ0sON51KlW36oNEyj4gF50Pg8D
 /jis+JcqnVlunIkGljWiYu6gNVXBXXiFqqbxnwWDGrA1e86Xl8A/aJn5tP/XELURNU7L1H1L
 f1g3K/usDaTkNsJ1HwmH378ctJTu7JYx/euCoz7MhKEJ2EgLC0Ob262cnk9JLAnpJOYPwIhA
 dgdtcdqASfln8gfP+6M+qFqOopfKA/9xLmyVSfxEoy4qdhlUC3GRFjZ5Ste2aOr9G0JXnWIg
 jccn/dT4sOb2lhKIKHiJmD4ns8Io01QPh/Cd6ecZ6Cx3InCQHyzMOVvZn0fdbO9/+348yRSl
 YOBXoViPxlUWGc/52eWohuleDhsrtn0aVX4d1zvhc5oswj6dKDDvDnnN580lR29sZHd5biBS
 b2RyaWd1ZXMgPHJnb2xkd3luQHN1c2UuY29tPsKVBBMRAgBVAhsjBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgAIZAQUJHC+BBRYhBO+WsixA7W+EivWnh0m5sHYwIjhsBQJamCrlEhhoa3A6
 Ly9wZ3AubWl0LmVkdQAKCRBJubB2MCI4bHt8AJwKjLlv73VEx6e63oQfUoOJKibHWwCfXIG1
 LHEVJbYPWAPKQ6Zk8ZCodXrOwU0ERoj26RAIAKKaKET9+fkkdP745IAQ17wrIzkpU/pAz90C
 fjJVhKngrb6PMFHyOPXlRAyJPCpp8Whl8P+KmAM7SZof4n8aLyrl+SVYFMe9RwYSshD7eNBD
 WmPNJd2qK8JJLUC8/ZRb5yw/bHfIRITogS9Tie5WJwHjMapizdQV8dyI+hSpYmWPDSOUaYCF
 T/nWaQP2NObZDFpBX3P8kP3LSTP+JW3Fz06CrJ03bAtm2CPDNI02sc5MHvRJXGNM2grvh+bK
 4V0sDrBeWr9sHy5ADoIx9PXGIfNH4NbSVBSGW3Oy8dmZnDfMgtAb9oY6HaGKZDj/F+AgxywB
 8oyvGfrJhfizIYROmycAAwUH/AtsttodDYydHeM9GFiZy0o/n4FAseYiMJKRI8fC2pYvrojt
 zbpQKXa64vQv2INtJHm8D1iGpzdrNkjL5jlqPKSUIkhwt9yUpOH3UQifwYOeKZUiv7vrapnW
 1gJb7RWhg4ske+qOa2FKvFVMsJ2quuu0qHOH0K8l7T8VqaW8FH4097c3TeSO17qRtwnNm+F7
 a+cXijMOaajZ9Xp4X04+wrEf7Rmvhc0zr96t3Z5QYx4ZwoyDfLefm5ORUe2CcRva7TnycB9P
 IxdGoVS2eIyepO+RMjvq5e6xjkpoiJ3cybQhsUt+pZd/KGSkZmhHpId3Y6zivOq7Lj+ELOtW
 dOTcV0TCTwQYEQIADwIbDAUCWVJ2GQUJHC+AsAAKCRBJubB2MCI4bC2IAJoDDDkaRi7G/lzz
 fUIV2179DCq38wCaAmivz68q3lkN6rF6vnh5DEGS74c=
Message-ID: <2f8d2066-8b2e-dab9-d1b9-b750055d6937@suse.de>
Date: Sun, 29 Apr 2018 04:44:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87efj2mv6i.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/25/2018 11:46 PM, NeilBrown wrote:
> 
> If "re-add" is written to the "state" file for a device
> which is faulty, this has an effect similar to removing
> and re-adding the device.  It should take up the
> same slot in the array that it previously had, and
> an accelerated (e.g. bitmap-based) rebuild should happen.
> 
> The slot that "it previously had" is determined by
> rdev->saved_raid_disk.
> However this is not set when a device fails (only when a device
> is added), and it is cleared when resync completes.
> This means that "re-add" will normally work once, but may not work a
> second time.
> 
> This patch includes two fixes.
> 1/ when a device fails, record the ->raid_disk value in
>     ->saved_raid_disk before clearing ->raid_disk
> 2/ when "re-add" is written to a device for which
>     ->saved_raid_disk is not set, fail.
> 
> I think this is suitable for stable as it can
> cause re-adding a device to be forced to do a full
> resync which takes a lot longer and so puts data at
> more risk.
> 
> Cc: <stable@vger.kernel.org> (v4.1)
> Fixes: 97f6cd39da22 ("md-cluster: re-add capabilities")
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  drivers/md/md.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 3bea45e8ccff..ecd4235c6e30 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -2853,7 +2853,8 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
>  			err = 0;
>  		}
>  	} else if (cmd_match(buf, "re-add")) {
> -		if (test_bit(Faulty, &rdev->flags) && (rdev->raid_disk == -1)) {
> +		if (test_bit(Faulty, &rdev->flags) && (rdev->raid_disk == -1) &&
> +			rdev->saved_raid_disk >= 0) {
>  			/* clear_bit is performed _after_ all the devices
>  			 * have their local Faulty bit cleared. If any writes
>  			 * happen in the meantime in the local node, they
> @@ -8641,6 +8642,7 @@ static int remove_and_add_spares(struct mddev *mddev,
>  			if (mddev->pers->hot_remove_disk(
>  				    mddev, rdev) == 0) {
>  				sysfs_unlink_rdev(mddev, rdev);
> +				rdev->saved_raid_disk = rdev->raid_disk;
>  				rdev->raid_disk = -1;
>  				removed++;
>  			}
> 

Performing a partial resync as opposed to full resync is always better
and less time consuming. Thanks!

Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

-- 
Goldwyn
