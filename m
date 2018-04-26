Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755520AbeDZLBS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:01:18 -0400
Received: from mail-db5eur01on0101.outbound.protection.outlook.com ([104.47.2.101]:31824
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754842AbeDZLBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:01:10 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH 3/4] exit: Rename assign_new_owner label in
 mm_update_next_owner()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, peterz@infradead.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, mhocko@suse.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, ebiederm@xmission.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com
Date: Thu, 26 Apr 2018 14:00:59 +0300
Message-ID: <152474045969.29458.5499629495380211357.stgit@localhost.localdomain>
In-Reply-To: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR02CA0112.eurprd02.prod.outlook.com
 (2603:10a6:7:29::41) To HE1PR0801MB1337.eurprd08.prod.outlook.com
 (2603:10a6:3:39::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;3:ZH8B7OVN59Vwh0UZWbsPpcp8sM5TwWH6nccHsMUbxmj045KtCxuv9xEoateyDUn9tTM9RlCYoduXIT2J3yhNEAeH3HOdx/7hJhAInAQKM9lr7aXKUnmO5PCpVXiJsiislYVMOBEhucU2kFZsGd6xxKXS3hw3whir0Gm2NJDj1XGtqwRwO786DFTrGsFfnMNQRylSVcquLdnnNsn3AzukS8GwXY03VIcBQT6H8a4ul9yoh2pE00Bq6WKVwjFedAhx;25:pgShSg/WtDJ2rXcDM/1jD/p+dGjaGHEUTlDCK6dh36FJxsvF2XJv2lGG0rcRbI0kr5bMsM9C4xWtwTUJ4/biY1wrGTM/VCmzlFz17If9n/MsrMacwS+JQkxjJkmL6pzjtUnz4pkCz4krolL1SLzgqnQP/j+SaFDQHNrXyLC1yPiLiTwWaDqh5RC7csrHWEPX50Poqt/9DHEV5d3t4UnR3YxC5Z9ftuv3mXTt5omv8Y4P0njvkDrIjv0JnJr++FWKrDt3uuMAu5PaM6rE6z5/1rbbY+cY3zT8iKkJoTYamAm+LUNCuV4/M+fgRy+T+L2KkFGZfQ6EOJjGMDTRpNZ49Q==;31:zVLNH4sh7YKopf3/KZa6slz9Z6nUr4n1SKXBvwhIP2Jmfrn8aovJhJusyXGy6BT856ZZDigEIUdAEaA715B8y+BH8o9nRcmmYhTsUlAiUowNztxmgWEkdKXkYCAs3SghWgYhxQnNmFGhXauYrxNmjEs3e94gXJFt1lnsSnjma14i8YeD/CTC+DzLkErVnstoH4V+dhAvwlfAg1tmGVlbpVFs9eSQYbNkkleudtW/Bdo=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1337:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:HokQPs2LjdEY/cyHVKpYymvwSEk0QTDKG2Q7FZfShoqHehtD/Z0m9Pl8Abx/Yy3IoQLIogYJ5ZCFSBBCg3MHLw6j7zpMzZiBrePUNzLygKXj2e6lNDX4GbBI7VJM9lHXf290YIFL46P91a5PiyuSYi7Iumgp/7I8co6pNUVbSS8nHjnqBiwyGgQzYfoY/bzCRqHpNe9ZZngDdwreWkraVhopkoBH9FQ22XpUoF5XcKawZdZpDb0Q2spiWJzLX8hqz3msdHxfq3MIp0RcW89rruofywuoYoSjguTa0kTCurAZIU2q+8rBemgVmx8zkgvqtcA1LOolR5NEF7eiglWfb1WLGcNX/8mv7Mb99s0SpMLS7F9y/UbM+rexCBRqC35RrtPMTNc8IoHcq6KRb6cUOEvwOPoXlibf9Ff4jDw9idmmfGm24AL0GvjtUGA4HxTCdnfTxqz8JYTh5Jv6Y2Z0AS0XoQyVsRIrw8PkOVHjF8icHOn5DbSTDuxZZN4Aouar;4:Qo5UhPJbolzPOkOBnx1/5kqAURcpR7E+NJzkG+rejeibqF+EelYqlWoEstAW1lF8TZCcHTqUHqjxc/TS/yXe5BSQWH9qtxHqb7/paooSK5FNT3iIgjM3x3o2eoIWj5TLa84uJdonzfB009wOxxn0rUZscFS2L3Dk8+68My0Tn/YWdIoNImNSZoa5VDQIRo6uMawTnNHqJ0jmiOOVDOLwoO5Ks6ZKrFGxr28l5IaIeUYFEYaNo1jXuxmxGiSXpDrEoZtXWbtzzL/kdnHzeUcjgw==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13378E7B3FCF55E27FEF02CECD8E0@HE1PR0801MB1337.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501410)(52105095)(3002001)(93006095)(93001095)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0801MB1337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1337;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(346002)(376002)(366004)(396003)(39380400002)(189003)(199004)(8936002)(50466002)(39060400002)(3846002)(61506002)(186003)(66066001)(58126008)(47776003)(230700001)(26005)(7736002)(16526019)(305945005)(53936002)(316002)(6116002)(97736004)(25786009)(2906002)(68736007)(55236004)(956004)(81156014)(5660300001)(33896004)(446003)(86362001)(105586002)(476003)(9686003)(55016002)(59450400001)(8676002)(386003)(6506007)(7416002)(486006)(478600001)(76176011)(7696005)(106356001)(52116002)(81166006)(23676004)(2486003)(11346002)(103116003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1337;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzc7MjM6VVdsZElwQ1l2eWNNeDJBbDFsYVdzOC9p?=
 =?utf-8?B?bmdPcEZaRWVWOVJKekJYMDFFdkJJTExoc0U0UGg1VE8vb3duQi9VQVptcjhk?=
 =?utf-8?B?VFBoYjFON2FsV1FiQmZ1dTAzbERyTFJUMzNCVDFIdlRGSjJabHJhcjd6MXd4?=
 =?utf-8?B?WkkzYnhsMnpzbzhJb01rWFgxNUN1YUNGaXFIMnA3T25QRmJGL1VYUTZTMmlQ?=
 =?utf-8?B?M0VuRVd6UW9ZK2kvTzZrajZzMEhBek1KYldBV0Y5dEppZTZqTmpmejdDenBH?=
 =?utf-8?B?ODB5c2xMWkM3YVE0WkRxQ0J3MFVSS0kvL3lhYlhITnhpQTlPVlBtUW44b2g3?=
 =?utf-8?B?QTUvbGczWFgrUUd6VURzTFJQTzRGRTN2YmVDelBKTWxZS2tlcys4L3Vna0x3?=
 =?utf-8?B?cVRMQjI5YldhZndMUjdtQlBPUUtCbUFaM3hjSmpkS0pKMm5rMytLVS94Mmd3?=
 =?utf-8?B?YkorVUxqT3l2bW5BcXJZdDMrMTRxV1FEZFpBNHBkVjlPRzJhQmF6NTVUZTI4?=
 =?utf-8?B?NjRLUW9HUXFydEFhM0FubFkwMW0yYzY1bURjRkRVUXNiS0FOd2ZuNmhFaHlt?=
 =?utf-8?B?TThXVit5UzlFQVo5djZtaEh2cHBMTTlSZEdnYWJ3RnhiWlhoUHczOVAvN1VH?=
 =?utf-8?B?Q2hhWlVnOEp5Y1paN0pEYnlSYm56aWppODVHbGppYVFnME8xWlhYZUk0OUlh?=
 =?utf-8?B?b3VxcGU3YU9NOFNqVTBSbDVJbDV0Y01qL3JsMlhrczhWcitEVWF5aWZTS25S?=
 =?utf-8?B?KzM4OXRzQ3hjZXhpeVd2ZFlkdGhZWmdCZmRYUFhnWGxxaXNzdGZVbmJka3JY?=
 =?utf-8?B?QlRDR0VScVhjMCtKMGhBQU01WDkvOFcrMEtENHIwM3BUZUdDakhVQVhtMjEy?=
 =?utf-8?B?WU5NeFJ2MUFCWGdwTlpUZjRTRWI4bEp1OVhqWG1IbVEyV0V2U1NVY2c3cEV2?=
 =?utf-8?B?ZmFhc3RMcnNieUw3N0VrY3VjbWZ6RTFUTCs4SVZhVGQxam8xRDhVU0l2Q011?=
 =?utf-8?B?OGxwL2plakxTWDhYdmJndVkxU0NSSEdVODBydTVDZmlXanFldkxEbHFIcXNh?=
 =?utf-8?B?ZVlJdksyM0dDZjVTSE11VXpzd0ZJQnMyYjhoYzZnWXBFNHY4d2kwdEptMlJ2?=
 =?utf-8?B?Y2hNRVE1eWcxajk1Uk85QTlEMEY2VDBpZXV6U2lzUmJic0d4N1dUMWc3Nkt4?=
 =?utf-8?B?VUNGaUpHS0Yvb0xNZEozeVBJZzUyUVQ2cCtPMUR5bXZ4Q1BmMGo5OU5JSHJj?=
 =?utf-8?B?VU03ZXJzak9KOHlNamdQK1NRTVNXS1ZqWmt2TFVlZ2VidnJTbHlTZXBXWXgy?=
 =?utf-8?B?djhSbU9QYjRJTFhRMmhoZUxZQVdmZjFISC94cVBweE5OblhVUTk1NUcxcFFH?=
 =?utf-8?B?N1plSHhUZnMvNDhoRjRIbGNxZER2NEFzK2FLbzBLaXlJY25UVHdFWVdPSGo3?=
 =?utf-8?B?NlVoZU4xbXNsa2NzNmVWOXpUeGVwSEpLenVFRGVuczdHU1ZkcUVIRFkvTlJN?=
 =?utf-8?B?ZFdQRjFYVkh5V1RyallQZ20vYmNiaVQvaGpRYis4eXlCTkZyV0Q3dDJ5S1Zm?=
 =?utf-8?B?VFUrSnZGOE9MZmNyVWZHeElFUVo2Sk95Z0xqcVE0T1FHOVFleFVZajl2dmQr?=
 =?utf-8?B?U3BRbDdsOFEvamRFR250bVN3NWR1WnMxRW5sYW9vVGcwVVFETExQckFrVHRa?=
 =?utf-8?B?ejNhT3lQRzZ5dVNhdzU5YVp2WEU0aUFVRmNxd3UyVzFROVlEU0xqKzRzaFBI?=
 =?utf-8?Q?UQECASX0/y/5QLSdPY8E5oGxZ6Ba5kZpKm7vo98=3D?=
X-Microsoft-Antispam-Message-Info: AVbA6NLVepGd9kmDjIvjPYnef8vh6CAFsnipiRZJ+64jkBpWeWQRUuf/gNbq6b6UFpDSEYu6TEtu9s/2srfJPEzEXkxw9Wo9a+GlwZZivBc9D6Y9ZOdsOYfJxDyPdEILBfrMBw3Box/xJVQ/IkUX1c4XI+fCUL16kjtCbI4zECcU4M1rYMlQziTdAqpXSGhg
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;6:C85G3JbgQpDssdPLlbGjf2LhP5ELCMb3pi2olWclicOjy+AZNosmFFHh2MnYkV4evvcEt4/Ge4wNR/uazE6GzD53zlEB8GKuDoZnRcOahth9xlxJCmtHuYNlB22Mx8nWzmDiA4s7QHhYpKji8qAI62cnqBPkxGe+qS82jNJX54hrgbGsmGR4mEewZbImbTQGi4ISEVQ/plwwHKWUM/at2bnr+eldbD1feZyBatzm6JXys6tUO7pS+tl8CKSErLtfBCeiGevXYrFg6nqU2RZ8x7y+acAFT8Km15Pd3mWpKTgjD6vWZC7q/kMUBt5QvE6KHA6dupBFxuKGVi1jrCncPvBkal24RXHZKWAiGOcHXiKo2tVIJCmYg2zaYlGA07DqXJaKnoKtXKR230SYqIcOEsdcb3tlunEUtZHullRs2BMxNlZwVgjaNXGEQrqE6el/yfmJZ4mu9uTqQrDeEdJHgA==;5:M84/gnXvMmmTk1PptGClhJVyvQofvsmcrtcsX993B3ZkunKIiqnSTtRnFyxTjToZXJvZ43Neuq9VWwvGABmm8NsgNV+PVMyokWgHDr7Vu8QoVF5GwMm/MrFbIVvjlGCAMwKl/Wv8VZSacn/lqSeYYFufX5YB+1mGzJvT2XRQe8I=;24:dcZ4IoZk5GCN0Nal2nglUtDt1+Nnmx9hwrsOy2QpihCT+z1UiknPIatXnm3BfsEiD6Xkl0BQbVENvRa5UoVb3N4CdlOlsPpmwWjnacRUkwU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;7:wYRvXdHknvSRSUetOiaow/gzTAMe40w1FmRT2DCrRy2WKdKAUIj3tselT0y3Y2HhpKGtOo+cDWLXKEYgFUEUSyyTNQsXdrsc6ATIQIKoeaDrZMidnSt6i21MOmzsAGd+PEs1O6oPOs/tCnrW7+HVSl+Pg068U4COrqtLvQCPyICH+Ld9YhIwckSaGCNynIEv2zlDHyxGIfvS223n/3bK8MOZXbZ6dLL3I3gqOkjpTyaay/pEji2hO7PZrGcnHkfN;20:wFUvGGyG4PNnMQVQOtoXHHVICTn1ZbAwVzL/6NFOz/w0payXFAdNpDUHsPukec0DG/l2fEJu1C9hlQA/vOTJXAv6vkruRrpHsgv27TtcRGh/qG9Fdvv+CE1NZi5Ct4jO/PcB+eDzdcG9z5rfHhbjbKeKAQxRC1tmw0j9NFOYLes=
X-MS-Office365-Filtering-Correlation-Id: 79f91aa6-ae58-482c-8d39-08d5ab65001d
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 11:01:01.8682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f91aa6-ae58-482c-8d39-08d5ab65001d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1337
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next patch introduces nolock variant of this label,
so we will have new_owner and new_owner_nolock.
assign_new_owner_nolock would be too long there.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 kernel/exit.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 5c42a9b9c1d7..40f734ed1193 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -430,7 +430,7 @@ void mm_update_next_owner(struct mm_struct *mm)
 	 */
 	list_for_each_entry(c, &p->children, sibling) {
 		if (c->mm == mm)
-			goto assign_new_owner;
+			goto new_owner;
 	}
 
 	/*
@@ -438,7 +438,7 @@ void mm_update_next_owner(struct mm_struct *mm)
 	 */
 	list_for_each_entry(c, &p->real_parent->children, sibling) {
 		if (c->mm == mm)
-			goto assign_new_owner;
+			goto new_owner;
 	}
 
 	/*
@@ -449,7 +449,7 @@ void mm_update_next_owner(struct mm_struct *mm)
 			continue;
 		for_each_thread(g, c) {
 			if (c->mm == mm)
-				goto assign_new_owner;
+				goto new_owner;
 			if (c->mm)
 				break;
 		}
@@ -463,7 +463,7 @@ void mm_update_next_owner(struct mm_struct *mm)
 	mm->owner = NULL;
 	return;
 
-assign_new_owner:
+new_owner:
 	rcu_read_lock();
 	read_unlock(&tasklist_lock);
 	BUG_ON(c == p);
