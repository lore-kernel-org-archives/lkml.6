Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeBKDv2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 22:51:28 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2544 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752422AbeBKDv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 22:51:27 -0500
From: heyunlei <heyunlei@huawei.com>
To: "Songyunlong (Euler)" <yunlong.song@huawei.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>, "Yuchao (T)" <yuchao0@huawei.com>,
        "yunlong.song@icloud.com" <yunlong.song@icloud.com>
CC: "miaoxie (A)" <miaoxie@huawei.com>,
        Wangbintian <bintian.wang@huawei.com>,
        "shengyong (A)" <shengyong1@huawei.com>,
        "linux-f2fs-devel@lists.sourceforge.net"
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] f2fs: set_code_data in move_data_block
Thread-Topic: [PATCH] f2fs: set_code_data in move_data_block
Thread-Index: AQHToNkSye/TONxW1EqEi424LqosAKOeCqkAgACJ/tA=
Date: Sun, 11 Feb 2018 03:51:14 +0000
Message-ID: <42B685BFA705F94C860C6DD0752F05654832EB19@DGGEMA503-MBX.china.huawei.com>
References: <1518093217-123705-1-git-send-email-yunlong.song@huawei.com>
 <a55bc2f7-fc46-4f4a-cb30-d6eb61b30785@huawei.com>
In-Reply-To: <a55bc2f7-fc46-4f4a-cb30-d6eb61b30785@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.111.187.226]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1B3pWQR022390



>-----Original Message-----
>From: Songyunlong (Euler)
>Sent: Sunday, February 11, 2018 11:35 AM
>To: jaegeuk@kernel.org; chao@kernel.org; Yuchao (T); yunlong.song@icloud.com
>Cc: miaoxie (A); Wangbintian; shengyong (A); heyunlei; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] f2fs: set_code_data in move_data_block
>
>Ping...
>
>move_data_block misses set_cold_data, then the F2FS_WB_CP_DATA will
>lack these data pages in move_data_block, and write_checkpoint can
>not make sure this pages committed to the flash.
>

Here, we write encrypted_page back, which belong to meta mapping.

Thanks.


>On 2018/2/8 20:33, Yunlong Song wrote:
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> ---
>>   fs/f2fs/gc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index b9d93fd..2095630 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -692,6 +692,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
>>   	fio.op = REQ_OP_WRITE;
>>   	fio.op_flags = REQ_SYNC;
>>   	fio.new_blkaddr = newaddr;
>> +	set_cold_data(fio.page);
>>   	err = f2fs_submit_page_write(&fio);
>>   	if (err) {
>>   		if (PageWriteback(fio.encrypted_page))
>>
>
>--
>Thanks,
>Yunlong Song
