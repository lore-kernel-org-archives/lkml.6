Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeFDDcP convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 23:32:15 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5553 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751210AbeFDDcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 23:32:14 -0400
From: Nixiaoming <nixiaoming@huawei.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: For help, whether to check the return value of sata_scr_read should
 be added in sata_print_link_status
Thread-Topic: For help, whether to check the return value of sata_scr_read
 should be added in sata_print_link_status
Thread-Index: AdP7tHwsYIItW1lIR5+8myT1DH4gzQ==
Date: Mon, 4 Jun 2018 03:32:07 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12A6828C7@dggemm507-mbx.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.88.168]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I have trouble reading the code, I hope you can help guide

The function sata_print_link_status in the file drivers/ata/libata-core.c checks the return value when the function sata_scr_read is called on line 3009, 
but does not check the return value when calling sata_scr_read on line 3011.
Why are two calls handled differently?
Is there any other code logic that guarantees that the 3011 line will not return an exception? 

drivers/ata/libata-core.c :
3005 static void sata_print_link_status(struct ata_link *link)
3006 {
3007     u32 sstatus, scontrol, tmp;
3008
3009     if (sata_scr_read(link, SCR_STATUS, &sstatus))
3010         return;
3011     sata_scr_read(link, SCR_CONTROL, &scontrol);
3012
3013     if (ata_phys_link_online(link)) {

Thanks
