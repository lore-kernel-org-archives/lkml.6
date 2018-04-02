Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752502AbeDBPHQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:07:16 -0400
Received: from mail-co1nam03on0040.outbound.protection.outlook.com ([104.47.40.40]:48864
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752318AbeDBPHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:07:13 -0400
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org,
        tony.luck@intel.com
Subject: [PATCH v4 0/8] Decode IA32/X64 CPER
Date: Mon,  2 Apr 2018 10:06:48 -0500
Message-Id: <20180402150656.101022-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN7PR10CA0030.namprd10.prod.outlook.com (20.176.16.43) To
 BN6PR12MB1905.namprd12.prod.outlook.com (10.175.102.11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7a3f6cb-703d-4334-fd10-08d598ab6986
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1905;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;3:E2+cZ1yGgMUKNkFBDvByJrd0zlUDKna5hdLO9EV5wQErIFEmwLo5+xF8e/0JwPrqBlTJj0rFNvtYz0ZX7JKcy/JCvOCEP6ANEZUp0O7iDY83ErlRZIGm/VMBucvBL+BcPYme7Xy/ToajKUuT4vNBX067E5989LhGvQcJgAsmw81r/cJKQU5BNak7N8cBiGuaDINluWw81WFzaHvKPwXy0yUtzcdNiknMoQjQqTjktuz3+KRTuLL7POg2JW8uTX80;25:9ZSJUDpbGTh6VRcn9pM4OSPoWcrL831Ryie0ayr1FDT7e2swZp6nzVrN+lKJgN7a4/Kw7JlTXosMWm/ETLYaVszL+hRolazzZj67qw3sr83ui/lpUKj87MDxTJrST9++1mEKuTAW3b7UyyXnzOsI23m7N1mDxQcc9FZxgT+pbyosBhZio9wFUXqjxIueknXYRRpeJPkfNiTCTNn4+JAqFrNYwHBRc9JAIFjkXB3C/+0A83WkxdHbJHbfzsSeZevtnVYrFTJV4hJZ5lFSwg94Qq/dB2TwSY09eJxC+W+hHxeIVgkiaeU6s5mwFE+vg344RPftUmzmLAjvDcm2gn95nA==;31:fK5LnPUF2RopCyPAjH1BMW498B09MnXaL1WDGT0KNVueZ8clZOgma0o4s8O7wpltr0m0H5BMGLtqVSbvyQHyETrAX5af78d8Rgn7giuBLp9EWcXjnuPahvKTsd5jqAHSt8EBU0eLfdo9yxiwEOfyftHVCc0YJ0mAhIn1gjeX+diRdXhm4xE15BD7rinaWIJ3nZXpfw/0oaiOw6ypOQyAUGg+zjWWkSr/3XMtHxO/WEU=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1905:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;20:igIo5luaq9hpRXLvFVMKD4D5w0Hpr0SwqmNXb0FZ6wo+cC+FAt4wiLmQ9vGC4pmOQJXl1u6E4U359ruo8wbkq5ItDTS5uj3VmgcQSEpvMQyLVJFJJYLYxDN0ndOsnskvawbl1k+3IbXB4/WA/Xw/ZyJQ8mXyX8Z1txsd/kOsesDYNbrJfi1bsunEADEWxPnGtAPceq2/osC3elnl0Mt0j3xSseA1fAJ2TJ+HG6hBCpsB93b7A9vjWbq1/Jd7isjlMYwlyWJe+CDNc7eD4bHtt1kmXWINhZEDcRdCzVVbdc3DC3c611Q/AChHiyOXaK7Mi9YYqK6hIaVfgI8xVvJG1I2F+OxEqmTtyTI0KHRurGKsXXQN7FRG/CPAb02pNLgQOs7M9h+CSdrtwvo6kqpiOUerauoBf++n6Qu2sct0UDBypPeCYUjrQM4k3UOJ0MAwAvShmpEwOgR9PyRjWyh7ecvPxAxMJeFV0v7kGXbOPkA5qsziGBsrF4R3VlQit69n;4:VRkdG5TPPJQZzaCXzJlWjtbLVjCR3OYi3se23QnRoUjqCUqwO8YxzYDAUgf//xt2pNp81Gh118l3ByiR5Ir0WkKNiZCXT0NGJOJEMz9Y/+jx4sYBsGGr2mZYkJ9WAGWxgjkrLVJbKl1NUl9LEP4lvv/ltqLSRpYyII+Cruhe6Y/Fcx37u4SJReRPsSxeiXH+g63hvZyw6n3vr9hRTMur5OUx/VKir+Qgu9HLh0w0PESbh3cX2PYaU4L54cAWbpq14E6JEwfLG62b3403x7wmNBZNR4f4yYOI+2S9JkSkoT5FpitKoDjr5Xh9h3JafcOMzBB+S//UHTE6FNVj/ZiGW9aRMwq9FHghuHrf5E6jNiU=
X-Microsoft-Antispam-PRVS: <BN6PR12MB19056931B508BD07CC5DF2CEF8A60@BN6PR12MB1905.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR12MB1905;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1905;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(2351001)(97736004)(86362001)(105586002)(25786009)(26005)(6666003)(6486002)(8676002)(5660300001)(106356001)(50226002)(8936002)(2906002)(16526019)(81156014)(81166006)(2361001)(50466002)(6306002)(66066001)(53936002)(386003)(48376002)(1076002)(6916009)(6116002)(52116002)(68736007)(4326008)(36756003)(3846002)(7736002)(59450400001)(316002)(966005)(51416003)(305945005)(7696005)(47776003)(2616005)(478600001)(956004)(16586007)(186003)(53416004)(72206003)(486005)(486005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1905;H:yaz-diesel.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1905;23:D4mLh3XjaDm2F3184WsTWyfHxIXz3Z7pk2LTjguCb?=
 =?us-ascii?Q?qINrcmpSqrgcT/+29A60E0I4gRDAixLKGjy1PL+RA6xLiMhGWE+5czUoEk9K?=
 =?us-ascii?Q?QRUBIYgcQ7UaFMolBKB6SpnGY7hS/EWZv93uTJeyhHr0x9AYD1zN5OOWdyqo?=
 =?us-ascii?Q?mPvlsJhysl6CkukNojL9jFRfOiGuahYABRkEO0Z8toso80SqmnI64sDHS7AL?=
 =?us-ascii?Q?sQWV7z6eXqzarold69JoyJT1ooreseK5zy45AkmHAMjaVfAxB9gp2a/ubIrL?=
 =?us-ascii?Q?W7wuipCMiqs2hgdBTbrEzTLizKK2sosC8sySpCO5T0lAw9Sr9ezwo80r3JV0?=
 =?us-ascii?Q?F9k/KNeyo080Sq/qyZbRNdtBWjViNcpDtjLza5PZklPvuyzyV8PQ1Kezvprx?=
 =?us-ascii?Q?JN7WGwkWGTsT6DDKRj0VnL7n6lyKc6ATmDZfrntyAhw7YiWK4naYipDrWg+T?=
 =?us-ascii?Q?XgF7aQ/5qPp3fB6PMaPa9GA7do0X8CpcoP+CFlXF/mENkyJC4quvXMpQTDiF?=
 =?us-ascii?Q?Nv2sqs+Kio6zjP2lnOqaTZy3AGwlXViCfvIYYk3vKtfipTpijQBDNBSlVlrB?=
 =?us-ascii?Q?JgUapLm5nr5HtIfhvQjM1AyXZOKPYK/n7IWYQo8+kUiKBZMXgY09MNMzpndR?=
 =?us-ascii?Q?3QKc8zp+pXyKHAK+x/kVS+4uKaavZvKqfTdPdbZpKUtsBN9zXU8cCj9MJjPu?=
 =?us-ascii?Q?dmLPhko4n7V4dLDhJDYS5qktczZmi3YLPRScVM58XOE8lPcZr7qxtaKcHMQZ?=
 =?us-ascii?Q?vQOyyLI2E/EdtEhWDekJw+CNyXDRqfTHZkjgRjIyOR9WRYI0mdwhQ6VqZqNL?=
 =?us-ascii?Q?SrY0bdxdnfPOOMy3D6yUw8MhfkTxY/Bw335jUIqjEr5ndOSEnd6tUQ3ptzQn?=
 =?us-ascii?Q?0gUaYPi7P3cxxb38tNQWe7NlqaWTSLVeZBa7WMM5Xr+130/eGHDhr5Fw3IU4?=
 =?us-ascii?Q?dkDQj2kk+9kESJHNEcUKbERJ60d0N+RXKoqA1+OlfUirOvAg+qMzGmh6nSAQ?=
 =?us-ascii?Q?bkWYG9Ume2iYptdEz2uasj3nEak9JR2nOE9GRHu2XnOoN4Nl0QnIBJLEtVIe?=
 =?us-ascii?Q?BUpZZ+k9kWJImeg44kd2GFffEZ8NJx40Dc0NfQKzdD/NOFm2ITsUfXyc9MD5?=
 =?us-ascii?Q?Prff4vYLQUwbajcvAX+6x+D+5CNPnuairM5egrKmMqLIF5OybiQR7w0WuTN3?=
 =?us-ascii?Q?2cy92fqSkkbn38l2tjlOL4ixV025++i4GUegdVayiubXJncEgKOIjqRkS40v?=
 =?us-ascii?Q?15C4/iqwXrn9wR6lQnRDRSvimP8noVjTipO+lwM?=
X-Microsoft-Antispam-Message-Info: m64kAyngUtOcixLmk2dw3dlkTFuU1LnnoyhX2q01KJbmYzDEJaNY7z5rP6mFW3cXBW/OqFytuWFSMWotICIFOjlu8iYm4dFMjUtIn+JFHBxRUzVGp5bxQMqeWJ3e3ngkFq1uxhHRZVS/b7JDy0KYfPa+gDgz9EXeYHfRfHXwPn/PBHZNBtz4RHJIyMCGi3RM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;6:J19XW34PBTiJFW9mdLi46A5EVZs3k8f7ujUNnmcz/Azz7RmrD2f0oO+9+bzFofXfFPjQOv0IiyCn4Zsn2Fr4HHwywR6gkp2HLOcHP1K7RG1Pok/PdqOc5rYsZVlwJ2BA8bYkeBBHLKEkHR4V+IODJ+e6/evx1n3D7N6gsx2HHHAgtJRLsRoyYDBg6xNmbxcg+RVaPfOpOi973Iz+qjIxzBAx/3Kgy5OE723zED33GY+EBuqwUor39wG+nrjXB6SuMyEN+GBAMyGDOQzzKF0VbMR06imy7+b7YrRpjnVoqS7v+3CqaWyBt2J5Z6aYt3mvruQ72zwdKXBLNpLofeCYoFaRqn7+nC9SFE5lVPM7NBkNwPRqOS77Hn6IXM+ZnDDZjolYKEzo5VZ9EsFgRfQ1Q6YOy/uWl4gyJlhfkOTiKGV/kyElnQMgh50ZUT89E4+RAO2nG+7c/rFHG4vSQUf9eA==;5:FNZ4hsvFvavdy3arfYDg39TYZq94ubYdlJgcrb0T4AKmkJBjQyCSKjCNpMea+EzU4eVZBeeH+Bn0xXSwZoKVqvIDOT6DBsJto3+wiwW3Ms/fODw/LRB0Mzvs3RKwUsY5junTdNnUR3S9GW/WYEVqL9p19DWPeSKRHXNhDSZFXHQ=;24:02OJvL4sXWdzE4G3JlA/Ty0/tKsI96AUFK0R7Nd4rz8ta/6PRu/Y+Ft0d/15JfdOe6L9Cjsj6i0KaJMz4hRCPjYTKeGUhyGFxbPyb6fUd6o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;7:Nc7UxK1SlVEOmOUfwRurKEsqS3JAGelWFcSE+1kL31dbKEH94//oJeRy9kC/r15ETd6aQF4AIfQxko2KEfXz6zqIopaXjiRwHymqOaH91UVEBBvA68xjZfFT/8nmDx9CsvaovnV8DpaBbN1O6o+mrepxeMUyK3g7UlknKyPdlSQBflDNSyFtaOJx0jipU2yOKlX7tXiJ66klSI7Jyg9POvXJYIqTLVF+oeA10JBWUYjpvvc3eokKTPhKCgbII578;20:u7qGlPTQP3NuKLhiS6AzFzB2JYcbCtD0nL719PxSsgucdTp42C9aEuOgdqK4zaNRHwzvxcG8KWQX90uzYQ6qMXyeX0U4lEkEAESYh1VhDgIyYSrsV5YqJxxIcXd5JC77GDUEdVgUnup0uUSOG0r5+GPLz2RyH+hmiAvGepVt+2OOfjx2EhL4iR8vnO7pMz8Y033nxNWlXNUTO88yRNClu/2qE59ip9X619gEf0Fm5UdRWYOjYbr2S3EUgC6HYLTk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 15:07:11.5973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a3f6cb-703d-4334-fd10-08d598ab6986
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1905
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

This series adds decoding for the IA32/X64 Common Platform Error Record.

Patch 1 fixes the IA32/X64 Processor Error Section definition to match
the UEFI spec.

Patches 2-8 add the new decoding. The patches incrementally add the
decoding starting from the top-level "Error Section". Hopefully, this
will make reviewing a bit easier compared to one large patch.

The formatting of the field names and options is taken from the UEFI
spec. I tried to keep everything the same to make searching easier.

The patches were written to the UEFI 2.7 spec though the definition of
the IA32/X64 CPER seems to be the same as when it was introduced in
the UEFI 2.1 spec.

Link:
https://lkml.kernel.org/r/20180324184940.19762-1-Yazen.Ghannam@amd.com

Changes V3 to V4:
* Drop INDENT_SP use.

Changes V2 to V3:
* Fix table numbers in commit messages.
* Don't print raw validation bits.
* Only print GUID for unknown error types.

Changes V1 to V2:
* Remove stable request for all patches.
* Address Ard's comments on formatting and other issues.
* In Patch 8, always print context info even if the type is not
  recognized.

Yazen Ghannam (8):
  efi: Fix IA32/X64 Processor Error Record definition
  efi: Decode IA32/X64 Processor Error Section
  efi: Decode IA32/X64 Processor Error Info Structure
  efi: Decode UEFI-defined IA32/X64 Error Structure GUIDs
  efi: Decode IA32/X64 Cache, TLB, and Bus Check structures
  efi: Decode additional IA32/X64 Bus Check fields
  efi: Decode IA32/X64 MS Check structure
  efi: Decode IA32/X64 Context Info structure

 drivers/firmware/efi/Kconfig    |   5 +
 drivers/firmware/efi/Makefile   |   1 +
 drivers/firmware/efi/cper-x86.c | 356 ++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper.c     |  10 ++
 include/linux/cper.h            |   4 +-
 5 files changed, 375 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/efi/cper-x86.c

-- 
2.14.1
