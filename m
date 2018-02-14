Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031926AbeBNPz4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:55:56 -0500
Received: from mail-dm3nam03on0088.outbound.protection.outlook.com ([104.47.41.88]:16901
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031649AbeBNPzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:55:53 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
CC: <mihai.serban@gmail.com>, <linux-imx@nxp.com>, <shegjiu.wang@nxp.com>,
        <daniel.baluta@nxp.com>, <linux-kernel@vger.kernel.org>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH v3 0/2] Add support for AK4458 DAC
Date: Wed, 14 Feb 2018 15:21:05 +0200
Message-ID: <1518614467-20613-1-git-send-email-cosmin.samoila@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131630973516273932;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(396003)(346002)(39860400002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(85426001)(106466001)(47776003)(5660300001)(53936002)(68736007)(6666003)(2201001)(86362001)(8676002)(81166006)(498600001)(81156014)(50226002)(26826003)(356003)(2906002)(8936002)(59450400001)(48376002)(104016004)(105606002)(51416003)(50466002)(97736004)(36756003)(956003)(450100002)(336011)(305945005)(110136005)(54906003)(16586007)(26005)(4326008)(316002)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB1412;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD037;1:bZbmlt0C55iBGL4GzUWNdJNsGAbZHEQgNhOhCWIee10/EiwJ7lw+Ipxe0sF86Xu3GyGRXP50Z0+IaqTVS0RTqvHTqxHrnDIygE2sxg2iDPzQEKxNgix/Fut+WOsaOEFd
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5be0dfa1-9a9c-444a-f7ac-08d573c36c54
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BLUPR03MB1412;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1412;3:zp2/9yhyV8vicB8Or1NL7xjgVMf5ir/LeZVFvdm2ey3ZtIzXZMpvshhzxd3bSsyA9JfD9AU+oEsnIXsdwWKBomOMjcUgLAj9e5f+BjciENCEP2SNIZJwPWcnKgM/rqR2JxFyfFGVUzLErk7cDt5eBl0brTQqCmdFbGim85XXS+Xl8yvLW1RW+YD+8T9XjDjBkxtEXp4OP2Qc1W7WnrWkuQf34Xaon2y/H3JDX4nPbvA7e4UYHjAbaAgZb+CwDl/rpDvzSoaqdaj9unX2skWCpwmBZE10NPENWyR29WI3yLtnZyDgWRJgNKMmdrIr4cQ/rBafLxB7+nkZ95PKorQrOD1fvuxEnZsHu+GfNq1iOt0=;25:gTfRHVSlRyGKWVit/c8xydixXKRrzELhFjuSXJT/C3QiSaHFtqpzCqoLNhSoN52jIgCknsSawiyvBfTTyJtiw9Z4iaoLCqKGc/kCHLfEsFYUFpO778Wm+kskC/HMtrx2GoIvB3wtKVbA4oGYpAaFBJjIcrP9okfEF8O5uhTb/H38XfAsnXmpIg8TJ32cfrZXpjFiUjChs4cGPtrHwCZZfFcbqemwjotU0exPVWwylOT1+7xj3Hjv5Mh5NzewNhxNAnE9gQ/lzgo4nUSV67QyJiSTBD23l39D4UHg7qrGeXRFC3UjtiNiAqX2NbSJf3DNJIvqarj9W+/Wjjw5nYL3aA==
X-MS-TrafficTypeDiagnostic: BLUPR03MB1412:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1412;31:4uG4/UBRjBYhYjM4Mh/L7nxx1qBL+sXc69ygluXtwc7Dr7kI5GZsPFsxghf4uMghtoMcVm4wt2MHq7M9lX2ZxDmJN7/1vXa3wNhRH8rNoekd/Y/cjRn68ieyddzSfvFhGzkhMP30NloB4fKBw8OMMWTg8CVn71NzzGOoDY5hOQU9I0pi3OceoQoVt9aG8YGKulEP+HxpezyLkSIBqg2CKoWFVgcg4pwLg/Q6ocmU2lE=;4:hGFtkpWmPGJgP4Kvoi0ez6n5zyKkqbID6AxKMT9lNQ67pdFh8+MDidkwWo8goF/YTyPBvyWcrHzI8vXMGRzVIK2da0H/zcQ/ASaa6/1c9ibf6yQA/DIIJv7AkT5PFC88LIlFUeJepfMGDSURzmRa6vt/s/nLlI1FlTZa5BF0Q71SMPjQurNz+LO0h/2yII5l3Q87x2zxezMYHDah0UN5gfAwAqATk3J5qoGkLeC8nkKlGVV31rzUVqX/V4aW6EWaxRaewFsgsZ8TDZE2ZMVgGA==
X-Microsoft-Antispam-PRVS: <BLUPR03MB1412A6D92BF7CB108ED501C69CF50@BLUPR03MB1412.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(3231101)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6096035)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123563025)(20161123556025)(20161123561025)(20161123559100)(20161123565025)(201708071742011);SRVR:BLUPR03MB1412;BCL:0;PCL:0;RULEID:(400006);SRVR:BLUPR03MB1412;
X-Forefront-PRVS: 0583A86C08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB1412;23:SuvnC7viht2qNchPptFH0mq/e2Tf56sk/hT924TDn?=
 =?us-ascii?Q?Rw+M9Bw9O4lwh1GYH+8esmEM8/yHIdllWXuTJEuxpH7jd1537XAcgMof7SYO?=
 =?us-ascii?Q?0yaw81WH1LH4/1cM9wjRZq3eZ3dc93/OY0IAKG9g3mfTtz0ZHMvsOf0SIGlN?=
 =?us-ascii?Q?qgUwfhjL4uOM2S++dw9CTvmeDRsO43K207Z+fXNlIRz0GXoG1acuXVsZaB65?=
 =?us-ascii?Q?RlXwE6Jg0+K74D61M839W2lf2HGB7sH9kVT6QDU9SiuvgEIeR/MV9ZXO6Bl8?=
 =?us-ascii?Q?/OFXlhLiRW5IdTBmSsfCDb0jwsM70zPyLKMnj1Q70G8jm29HUOs/pVlKJgaj?=
 =?us-ascii?Q?67V5JwTvbWohMEEIjzgtmugHXk+XeejFQA/LsPpyQpbqPGA1vNBKYFiEARLH?=
 =?us-ascii?Q?0D7DJwsao8woJe1Zx2L8pR66rfRQbXklfBn/hdq/dijXvEr9xPDTIMpbVupN?=
 =?us-ascii?Q?PMfdtx9wGb3RQ71Q7uoF8BKBpP3BWhNc80Ga+4yqX0x17BBZcnIjW0daZy5m?=
 =?us-ascii?Q?4ic7qBgHWYrX+xcdZy/NVNNur86noujIbhv0rU3xsXTJe85h7SxTY/GmjZ/p?=
 =?us-ascii?Q?Ynfp3LFBE8XpS57Y4GzYms6Xmdsb9y3+Q8fDLGTP1fMjrnKatkQ83Y5F2sUt?=
 =?us-ascii?Q?VL7lhh0UXIboA3oXuOU+EjZmZ6PZtLUgSjskuwjwCVDoACj2Au00QV3uKYBc?=
 =?us-ascii?Q?6LlmNQWUVorLMpRj6sLbNo1dkTaIRnEJKMum4RJu3DyWAAfdIoxBv6McCjXk?=
 =?us-ascii?Q?Ar0UaJLCVYOjgHCSmOkyBhakCiFaH2AzksUjDJjlwlnjfuUcxXKUqoomm9n+?=
 =?us-ascii?Q?MSDlQcPNsJG2syFlMQkX3nh5hHXV7zcnFAUMiRcjheeTLq8bvX/K4s2gvzf2?=
 =?us-ascii?Q?QhccX+ynltpVzGno8FVR/lawKogIm4bteARBS+HSQVWF0R6RIUjJZ3Xh37qV?=
 =?us-ascii?Q?HjGYOYtyZn8t+80EYIrIaM7adxWJjLDApMfeOVMckBEjuXIOQiZQYdB2FglN?=
 =?us-ascii?Q?wVlkaMavOQaZWbhVsKUXwDZpuZc4wFJHLG7e4+itRzWRLV+7zLM7i1WYzpRr?=
 =?us-ascii?Q?gRzSOcxq6TxQJXnczmoSBRq6FZohHZTvnemEACbpoy/vXZLdgDEK96Je7D/K?=
 =?us-ascii?Q?nfqyS/tVKU=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB1412;6:OEARNBWol3KCB7n0FU1bxalG2DFLRalHhxTE5hEKJ+0J4rlnEuiXF8AGbzIcfzBqEt77g82QK2ZnoDJNC+BpUkzIJViQN2bzrpXfpirhtlETLaWU0/qZZ8Pfjk65Fi2wvzk/0ZsjFb3L9rTQJcRbKWnTC0+Mw5BHP1s842RlGLFZLBINtHKaKrPngKmhzfFJTrw0EmP/xhLheYSAv3bfxTxaQinE1+z70kjtb23oOMdgNYMUuhM2pj85x3iYSH182dLhm0FwIVxspm5GkOP2sVF+MVr9u7edYs2YUy1fa3UWBOajOM+/gSAnGxaaouQQ2COkxQ6DN6juSHajKjUBJ4p6VfQjVRunPfKLdojhp1E=;5:0JkZWnhmdQUbfrCH+jYoIB3YyZ4v2p6+7DUgA6GpWCa8OjMDDDcWQyKJzn0yAbDAM3gkbf/ngDEr/KbWObO3lEP+C3Wz8qDvsVKdFoLa5QeM3i/66pXVjwHnWYuDIosHxS0jFUX4MAcH2W0ECkZF375g+SGe4mNIQqM8/G/pk+U=;24:eJImLjq6NJTEmA5xZvrh3jwSfgfB+ASdf3J/EC/JF1JXiAqvegmR42fjv4+0Zh2cigb3n8uJDG8ccXx0o29ia2nfOFINRHH6znsHgks7k40=;7:qwW7cS+Ncnr9GS7jZujleU1zFXsLXl70+u8iNnnTD45xr31aOpj/sBtzQskAZwSiGy+o0qYF0Fz8BP4owCWl5+NA6t7HeH9RMEfNAqD8Pd3ThUOANUlLXAcyc80fAJsD9GpNdLNJixBCSqYRG4RAalSiIXnddzTT82bRMoRJPXL635g0KXI67c/T3SR8sWkfLd4uTgzn5OZ9AGPEvp/F81gQ+7wyP3X5z/TEP6XuZC88QaWUVdW2r0JD9AUUcl50
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 15:55:50.7069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be0dfa1-9a9c-444a-f7ac-08d573c36c54
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB1412
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We support Normal Mode, TDM Mode and PM.

Changes since V2:
- remove unused code left from V1
- rewrite set_dai_fmt to only remember the format since
- the format is rewritten in hw_params
- use defined constants for mode in set_tdm_slot function
- use GENMASK
- add commit message for bindings patch
- modify bindings description text since we only support I2C for now
- rename ak4458_codec_probe to ak4458_probe
- write whole implementation of regmap init and gpiod get in i2c_probe
- added ak4458_remove where we power_off the chip

Changes since V1:
- support only i2c
- i2c probe / remove/suspend/ resume moved into shared code                                                         
- change enum array to separate variables
- aggregate Volume control for Left and Right Channel
- remove mux from DAPM
- remove unused functions
- remove unused controls
- remove unused macros
- use snd_soc_update_bits instead of soc_read + soc_write
- use GPIOD
- use SPDX identifier
- use dac@10 instgitead of ak4458@10
- use explicit power_on/off functions
- add __maybe_unused attribute
- use probe_new for i2c_probe

Cosmin-Gabriel Samoila (2):
  ASoC: codecs: Add support for AK4458 DAC driver
  ASoC: ak4458: Add bindings for AK4458 DAC

 Documentation/devicetree/bindings/sound/ak4458.txt |  23 +
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/ak4458.c                          | 659 +++++++++++++++++++++
 sound/soc/codecs/ak4458.h                          |  86 +++
 5 files changed, 776 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak4458.txt
 create mode 100644 sound/soc/codecs/ak4458.c
 create mode 100644 sound/soc/codecs/ak4458.h

-- 
2.7.4
