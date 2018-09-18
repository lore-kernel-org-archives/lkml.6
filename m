Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30837ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0506206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hfc3rXuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0506206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbeIRPQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:16:55 -0400
Received: from mail-eopbgr60139.outbound.protection.outlook.com ([40.107.6.139]:43456
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727757AbeIRPQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOXoZ6EA4YQmeqItI7KC7cmZjIYrQzWi/S+NqeSvZIY=;
 b=hfc3rXuM2C8L+KiYgYnNg3QO/9SnfXRMBaP0Sw1zC5RFmEEVRYAyj7CicUBAwTW2x8+jZihOYUTABg7WZA9G2ppfoA0U6R2UwhLe774RVs6hwcMToJ0MzEWuvRE6bBujBiQWPeznzG9tQt3MzEJXzxi/qVnCV2YsdnVYFEaIHxg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 AM6PR08MB3254.eurprd08.prod.outlook.com (2603:10a6:209:47::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 18 Sep 2018 09:43:10 +0000
Subject: Re: [LKP] [vfree, kvfree] a79ed8bfb2:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lkp@01.org
References: <20180918085252.GR7632@shao2-debian>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <7e19e4df-b1a6-29bd-9ae7-0266d50bef1d@virtuozzo.com>
Date:   Tue, 18 Sep 2018 12:43:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918085252.GR7632@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR06CA0159.eurprd06.prod.outlook.com
 (2603:10a6:7:16::46) To AM6PR08MB3254.eurprd08.prod.outlook.com
 (2603:10a6:209:47::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: deac68b7-8660-4fe6-ecd2-08d61d4b25a4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3254;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;3:CAkqnlAUmxst9BuBWQaVfqywKkLFk3o+qsMyC1UBUhvF4jrxX4diBvRTZ34f6IEzlRP7j4LIrSoEgf1LHlkgVb0155uQBJshlNOEc6JRnphXjYJzQu3PL4RlXHtt9lZHsamBpuIRDKnrHp85vLb1mktEJQ2A0lRyYwHWITTKQM5haGppZel+lpLomubDlZA/1KOOA9gM1GnEdfGii7BattHQJ1AKTte3/5TP71xNVYINW0Yqj/VofTYvNML6QWTz;25:2oAPNUiRH7a5cL6k5OS56OUTBftza3gxYrHjHulHqAZ99ce1JgyuP/ygoa+ZzE5qj/Frd4ITwQgKE2dhqkwHCKB26E3vBzyAuMU0nitm0X9F8sHw+bAjp3ub9kO67KBcYE0iiaVmhUcPLDJRvxAbaadVUGL8AetN+zqodR2cWPHqn7bpa4Gb8gHode3mKIVDPN/jUypR9qPI4Mvf2LE5xkZEU5Ad8alZbaq3FsOCnU2dBoGO/d3AP38X/yw3HnpIJBmwwaE7LED49A8c7xLTLluipxz2Ifb4j/cU7TFQBB979/n/Mo0+eG6ACNeiIpVa+wgs8PTfkqMYvPnNKdzWJg==;31:IfUZH4G7lEFK1EBfkk50ET1aOYFlJ9pWJtwVTFLNPopDTknHQTbPkpYlOavWovklPKpIsWX7HYw87cHPOIGLmsUdFW8MNBri3Wdk1Kf6UMjkOZkNE18OC24XWGuntPZaGbuBAvMYscAfI2351S4PRbzKaTsQHHwNZWNZxbtZrKKNg2WcHsx5HO2beiBZIU3bOwEz9eEjUZ00BUwiGd1qYPMZrjxACk9qgydaCspvH/g=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3254:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;20:cQ2aTZFMCCq919MqLM4JgWB5AJLyxoVukTJd5h/2yS3CdIeaKBP0DeNzUGWsVPFL5WughXySEKFw2StDEHy6QZO09gfi52DBjKzYVS0FQiR2KGxsADRDeI10npjEe1JwYTJ1zuPiOhy+W3PGv9sUnunRrIIUhRrwpFUrVdR3+W+swQ+WDIQo2DF2GwWLHeYqHh7nMd6ZZkFGFIqzjX/wdJGuT8tW1ZPBxn0rvYrPR3FUbs1aTaMy40ybU8tlDRVQ/gF1xe20aeQiR2/znprdLqpmBJCNhkmn9EuBWINJ1uF+OED9vGeV0zAegcdVxBPSGRBgpWjeUxbSq4Aa5s0QdWYZISXVESSffIJ0zOFcDWErSwFimD8Ank5XCIbZ030QAI74xxPC3lHU2HxpwNVyhQBHu+ILsVBdyAD/swRQBmN/QGX+9QZ1JliN4iF4fQdun/vdxEo64xHZf+cAA0PQaTQrJZGux1c7wUi0d+NLGBmmh0ccfD1bhcSNg8wplZgF;4:p51RPy/twR0yYKfJaFHSnNz5sGzzTjDF87Z7c5bY5ij4t0bofDaFzheDPTxhsfiQYUes66RveHplx3Ide9la+oj9opgyxAlcvzZuKC2BLMyjLUAfSTQhH0YcAAtLtA3CXTXdU2MYpAGClrZk3/oaK09uu4DrzR/Iz40MN+oBDiDWxv0qPBFMgk20vV9Cwie5raokOvZwGm9IxJ9TV/UuXcN7Dmi3q4ddOeoFXTAv6rWY7gx3lnjsAhCbsnIiqiFUEyFvtYDY/BwzBdyyJT0XlQ==
X-Microsoft-Antispam-PRVS: <AM6PR08MB32542449BE9BC10B878F4904B01D0@AM6PR08MB3254.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:AM6PR08MB3254;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3254;
X-Forefront-PRVS: 0799B1B2D7
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6049001)(39850400004)(376002)(396003)(136003)(366004)(346002)(189003)(199004)(26005)(50466002)(16526019)(478600001)(76176011)(52116002)(23746002)(53546011)(3846002)(386003)(316002)(229853002)(81156014)(25786009)(106356001)(54906003)(64126003)(47776003)(6116002)(77096007)(186003)(305945005)(230700001)(4326008)(5660300001)(36756003)(6486002)(16576012)(65826007)(105586002)(31686004)(81166006)(58126008)(53936002)(8676002)(65806001)(66066001)(65956001)(6666003)(956004)(2906002)(8936002)(97736004)(11346002)(31696002)(68736007)(6916009)(446003)(486006)(476003)(6246003)(86362001)(2616005)(7736002)(14444005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3254;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;AM6PR08MB3254;23:7n0UwhMJwFQwMRRpryvghDzfW2PflymqFjyZX?=
 =?Windows-1252?Q?FrgiwYro3CgHSo3zAaO08K3ykwAxSowhvePWHwMmZBZh3f27NJQ3ifkX?=
 =?Windows-1252?Q?OoUDzd53DN2D3O6j0noA96mIuWDJ23Lqbi1P0U0/Us7rqeZDINQXHTAZ?=
 =?Windows-1252?Q?4s2qaf+H6mtBUsdB5qdWRGb727Ode8ih04Ut7kCwjBGY6cVIfsoOsuHf?=
 =?Windows-1252?Q?+Fdr6XBpO+lORmHuv+Qo8lB3NgJYfN0CLkzN2W14byBRr3C4D3WbNF+I?=
 =?Windows-1252?Q?Kd6MgeKLxywBUGBohyWmgL2cynBvDFlIakMg7uQl95B0kEEt6wyiXOSg?=
 =?Windows-1252?Q?SMMxRYIL0nP/LbVfWOM7nZd8rkzW6Cg5ZccMu7rYrtjX/upmKM+EolTS?=
 =?Windows-1252?Q?BE/zC1T5QegiPa0vUxZihVrRivxa2KHzvvOxka3CPDgvoEoIOCFTvcI5?=
 =?Windows-1252?Q?fAlLyp3kWVBmPOCp+avfJXpH8QfszglRz/C5mRS2pbJ0IAM0sfmrQkyX?=
 =?Windows-1252?Q?772HuxgXCpVGD92nWPMly8W+u+x5AIsi/vUlanF+BJbKiLLiRv/2BLX7?=
 =?Windows-1252?Q?GjOSD9VMpQqVXdZKs/oEW/TU/Z7HXybJjz8O96g+0hW+3DDzvcvGzQlg?=
 =?Windows-1252?Q?1po25JTRTNbOh5ZYfKtWG5T2Ce+yc9OnElGKKvbOg3Xx4CKpnBkaS9fM?=
 =?Windows-1252?Q?q4vL2qp0CRFegrmLeXCIYHOrcpMLTDYuj6BLlrBosw8fezK3rXlUy4UJ?=
 =?Windows-1252?Q?yZ9a0NbbdCEOdNWwdvy/H36OayzyF13aoyuraCaZw40Q+J7tHF0cLdCd?=
 =?Windows-1252?Q?JtLf5IHCCfr/z/MF71A9EY03z9do4gmFfhzAdtbCo/Gwowc1BGeNLUCY?=
 =?Windows-1252?Q?m3/85MZ0ly2v6ggRDkMOi/SJyCKGtGIHku6lwvmdC1PH2Nc5dtrEtviU?=
 =?Windows-1252?Q?ffTj9rcrZx752W49uB8JBiOy0jwLznJ9Hp/JULLgKlFNTb/+xJP0Z1Ue?=
 =?Windows-1252?Q?PaYCNEoEYrWNk0OYxaSvq9xTt5bP2vKT3f/oRpRQJd4x9BbD4b69muf6?=
 =?Windows-1252?Q?9EIcVjpUfdQgGqTKNa5LenwhHngN+fLGGlblI+qoiSfCuK2o7YZ5rUQh?=
 =?Windows-1252?Q?eii7vbI7gkBqoaMg1mDFvrs4eOtuO76Pfw03WxIjt9cOxvFScSz8xvWW?=
 =?Windows-1252?Q?SQfzN7FtCqdabx87ii1qAHM3x0NNxbfE81MnXmuyraK947GYhur2uZvo?=
 =?Windows-1252?Q?DpBeiNlvNp65ZyLA7CpjZ6Z9BdHH4QinF47kBFqMRIZiL/64OLs1C4rf?=
 =?Windows-1252?Q?xX0NKUWmICKpLYCmW5a4dumIRWM4CoMhPMEvJG96q8m6+rI3Iaqnsld/?=
 =?Windows-1252?Q?b7YOupV6awXGVrZrii1033l/psJZWSuN/hHXIr2vjdK30SEqILFm8B8s?=
 =?Windows-1252?Q?+KstQvqAk0Kk/ohqWUAsCp6oAmb9vB3Zc8io8Ijl8iTyywFuY8MdYxXU?=
 =?Windows-1252?Q?1avhBp0b3GKx3ZE3uZpbAr66NtzOcJMV4nAciFrj3z3kG122sXevtTqh?=
 =?Windows-1252?Q?OtcGPdYq5xRmk+6j49L+SHKV0GdiIucFvR826wkRKyDuwwCZAf8l8rL4?=
 =?Windows-1252?Q?rYfa8vTGHbCesBC+lTQSyQ=3D?=
X-Microsoft-Antispam-Message-Info: Yn8GoYPpspzgEFZvRIRSdBFo2IxRSAd7/9E/Keo/YwZZzZnimmSr0H6y9w99A3PtgAIUatdPukCuA85tXnmvRzu8zgMP4cCAshHPTntHD47zks11t6vi4eFZWcSCKrrlDdy7pXxQCFszzHqmIgoJnGY1490VlJdm5egzi/lUX/FPIjKl5GjLmte4ogFAenm2zRVzoPQN1kVcbAq5gp8G8HATfltyjKc1HEbicOoXV1qw1C1C2pDFFAKip/vkQ54osHbdl/gH5EbTNHj3SpILN5lLkaf/bwBxbZzn5sSGFsZtXBYv0DiQWzFK8cFkJlrR998m/ejy+xo9L6heh4hjX66cddVvBzo55U2Vzam9amw=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;6:nUaRqhfssiYAfOSdg5M+laOrzbtp2+E/5loLs/A7hgRMZhTWQEkkYBOIDIKiO1nk1ayJV5QOWQtga1ghc+IaX0Sna5QW9Kp+o/IkJ4k0sn+JlYwer8rb0H/sM9CRmWLo0lGdO0PsUMDIjJVh0dfmoLLWWppkdSGppU58e7s2mJN0eV+OdtwK5zoaXioJM1Gwjhn3W3Xw3JXj9LobVevN8dauI/PBdev4QlqLgjbLw9mNlRHsEp71IX9MfXFt9ilGSBZCfReIRdezg1JQRIEBKA7pBV3onaJSSreYnkOKtxQMf3sduQrClhgoBywFo0Aoh4lfjLCJ60olJobEtUJZDVHJZWlUXNKyHgddNhmFy2uxbG4E9c05XuDEVok/STq8yp3bHJiC+cYjGsRKTxlh67SQb8Kvdh7xKn4lNyfnKfbDTIMwvOMcF7EzZlyFf4v/2Ap90p/vTBssY80K8HIjcg==;5:uTE+qMxreAFmZ3MJIu/keInFzAv2lYJ0JIgqqZIYa3ej8pHJTD6o9M7iORW03++ZkGEt3l8AQ1MpzJZQvrir80QP3IgwYqeQvKbPX8yfiuKoWrDrDm+H0945TX8rwmJfkQW2sq5AoG8aYOPpsSKwyN9aAogfdZqhRvBMRc1v4bU=;7:vPu+rXuEFheFl1tSW3I3uoj1WEjouckHmXjKaS4TKtglN4OFh1+p4bgZcNWiS57HrS9i+vs/zzKyvd6xQY198H2bAjQHzCRpmV1miGP59FH8j/duBViu8SHuTEtm1f0WdIiZsX7AGaZto+1CQcAlrNVqm3crZWaqPy/URSF5jSsbyNznkZquIV6kWg0gQ5Z2bvSxZO5Y/O5zltukEAVA+m7Wi2m8cgaDxGzZXTME3fhi7OPEKvkv80w+DZ5a7AIr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;20:j2QYX7weHQGAM3fGg5XFpgey8WetT9J28xkT7x5kRcsbkEMYe+biP+F28+HdJQRqZdlYNgA6zG7FJRHAv+CD4VhpJvfCoTScph5AuHqonCA7iMBGhqCNgMzarVpmx7NUMexR4S2KJHPQ2N/K4sCpBZ8y4RYfvb0h3xHYoxJJF+o=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 09:43:10.4415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deac68b7-8660-4fe6-ecd2-08d61d4b25a4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 11:52 AM, kernel test robot wrote:

> 
> [    3.265372] BUG: sleeping function called from invalid context at mm/util.c:449
> [    3.288552] in_atomic(): 0, irqs_disabled(): 0, pid: 142, name: rhashtable_thra
> [    3.301548] INFO: lockdep is turned off.
> [    3.302214] Preemption disabled at:
> [    3.302221] [<c163e86f>] get_random_u32+0x4f/0x100
> [    3.327556] CPU: 0 PID: 142 Comm: rhashtable_thra Tainted: G        W       T 4.19.0-rc3-00266-ga79ed8bf #656
> [    3.328540] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [    3.328540] Call Trace:
> [    3.328540]  ? dump_stack+0x55/0x7b
> [    3.328540]  ? get_random_u32+0x4f/0x100
> [    3.328540]  ? ___might_sleep+0x11d/0x170
> [    3.328540]  ? kvfree+0x61/0x70
> [    3.328540]  ? bucket_table_free+0x18/0x80
> [    3.328540]  ? bucket_table_alloc+0x79/0x160
> [    3.328540]  ? rhashtable_insert_slow+0x25d/0x2d0
> [    3.328540]  ? insert_retry+0x1df/0x320
> [    3.328540]  ? threadfunc+0xa3/0x3fe
> [    3.328540]  ? kzalloc+0x14/0x14
> [    3.328540]  ? _raw_spin_unlock_irqrestore+0x30/0x50
> [    3.328540]  ? kthread+0xd1/0x100
> [    3.328540]  ? insert_retry+0x320/0x320
> [    3.328540]  ? kthread_delayed_work_timer_fn+0x80/0x80
> [    3.328540]  ? ret_from_fork+0x2e/0x38


Seems like we need to drop might_sleep_if() from kvfree().

	rcu_read_lock()
		rhashtable_insert_rehash()
			new_tbl = bucket_table_alloc(ht, size, GFP_ATOMIC | __GFP_NOWARN);
				->kvmalloc();

		bucket_table_free(new_tbl);
			->kvfree()
	rcu_read_unlock()

kvmalloc(..., GFP_ATOMIC) simply always kmalloc:
	if ((flags & GFP_KERNEL) != GFP_KERNEL)
		return kmalloc_node(size, flags, node);

So in the above case, kvfree() always frees kmalloced memory -> and never calls vfree().

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 mm/util.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 929ed1795bc1..7f1f165f46af 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -446,8 +446,6 @@ EXPORT_SYMBOL(kvmalloc_node);
  */
 void kvfree(const void *addr)
 {
-	might_sleep_if(!in_interrupt());
-
 	if (is_vmalloc_addr(addr))
 		vfree(addr);
 	else
-- 
