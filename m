Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeEGKQF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:16:05 -0400
Received: from mail-bl2nam02on0061.outbound.protection.outlook.com ([104.47.38.61]:27728
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751889AbeEGKP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:15:59 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        mturquette@baylibre.com, sboyd@kernel.org, christian.koenig@amd.com,
        airlied@redhat.com, Shaoyun.Liu@amd.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 0/2] Add support for general system clock on ST AMD platform
Date: Mon,  7 May 2018 18:13:31 +0800
Message-Id: <1525688013-9928-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::15) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2366;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;3:xQYK8JDtpqRKyvaszsxxOfoSvW3dIvrVIWB2U9Lesm71gDgPmToI7sELaX5T826eXuiMA65hA4d1fEa5ZHhQkNL3mufwxdE0TP7OTYhU+3Buij++z8J4pQvNhPBiPMTWfmvqZPWNrnIzeKKxqNvm7uzZ5A177S0toEi2lLTPOmxue/Ox216yXS86iKvVOgMNQWX+1deHc58slIwOYGwq9BJzDReESBRo3SjJrFZzLCoRS+FonAlOdJ8vG49Xo1wh;25:cfneUBjdc1+rk6w5XibFD8ydGJiCv/KoNTpXyG0ENYSibYjg1MkeFI6LmPniu6DpHcyXnThE/Yn6FwcKQi41/ilKeW4zuaRQgZ4/fhG/Q4NqNyGG84KnKoMSg+RV/m9mEPYCryv8zx/HnuPFdvMbNJplJd+Bldlwuge/R8ilYtrto1hPA4vhkirkpOQrSAzh3Qxnm0Wg9D2Tez+CLym/6afpT564jN/Zyb2twDBNfF7kEGMVQ1grhPs7mwsT+QPXn6DiKVXbrfRCan07L7/NkpSQzB3qdTuCwOjVrdIx+y5FmJ9nS44dNKEbl07JPOahlJ/4lG/sxtYqeYS3EM/HqQ==;31:spUB6cR4eJDoSH5dRQebAI+QspepOlPUFtnvhkfHnYtUCj506/gfZNvuQ0SAZUYtaDuJhmD0CdXBdDAIbI2EbPGdc91tFcgn7GESXI0YqDhuoRbDqgYCjYhU9IG9lz9mz/Bb1gBE7BMf7N5X1dqSm/gpLnpc2kS9YfiEmgOW8EySQHd218TNdpUQqFmEr3KnaE1dP4hcfWg0KgszAFYu6GhfkhViTHceF/fqV/KksZ8=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;20:ufu2Imz/FS+0BWwcYzg+f3+ZoG+sfWoMUaI9DGQ1gbQaGotLMtoTpE+M2vl0oB08TGJeAW88tEvAmAxb3dbXoa9+AmM4koVmAaRoJlduJbCTbUy/0a3/lR0g3+rVqve160GKbbq5A4BLHXf2PvmIXz5fV/DQztj241itzorrpiCHzhDbnnlw8FzAymXE1LVgVZ+bAEelrTcjJU90oNPpFyIAbAXLU7rvYYbFwSKmt+PJJSLYqwjJfYJp81AXjFhB6Ma+hfhYG4IdP+paZlyU5dLrPqSEsT6bAbC2r272vP1sJkbkkgJfMgoOqS5+s3xmZCaRbCVC8Yf1Mz9QCqLZ1mbIAq7L0c6MniZK77YvG5eLSZpJGvot6U2P9FXVNUS4P5U3+XZV5SmTr9aoWwUv77YJ2WcCELkmPlPFf1ZzJOlMDgZSNHiPSHRLgmU72scit1PXgv+lXFrzWh2IzODiRdrdbnelMwosuLYWRKTn+327dxxkXnQF3L3TkzBxBscr;4:ozQlKkM8i6PJGCQIk0XFIkZZ0YFb74hxQ/sGo7UyNK8UDddj5ajRRx1LrWF0v0MN1gSUxXirYI2I+QCcxY/aP5TDo0nAnnnKOc+NpwjiuOrrVE5whY8wqrTzytZP1JxrlxhnpaoKLMnc4YZW7UKUhn80s9OTkuENvWQYMll1BJQ4n6JBI5cd2L7mx+20Ub6QjGAhncpo4jnkfjfmKV7nEhHojU5ab3wAGD5hUZjvUsEVI8cV7lF/QZBVmjLwq0kyiTxc2SxZnEEjbHpxBpjxyQ==
X-Microsoft-Antispam-PRVS: <SN1PR12MB2366485A2217F900A5F33D93F89B0@SN1PR12MB2366.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:SN1PR12MB2366;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2366;
X-Forefront-PRVS: 066517B35B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(396003)(39380400002)(39860400002)(366004)(376002)(346002)(189003)(199004)(54534003)(1671002)(50466002)(8676002)(48376002)(66066001)(316002)(81166006)(186003)(81156014)(4326008)(44832011)(6116002)(69596002)(26005)(6486002)(3846002)(6666003)(8936002)(47776003)(305945005)(16586007)(25786009)(478600001)(2906002)(68736007)(50226002)(53936002)(36756003)(7736002)(6512007)(86362001)(105586002)(5660300001)(52116002)(51416003)(53416004)(476003)(386003)(6506007)(72206003)(16526019)(106356001)(109986005)(2616005)(956004)(486006)(97736004)(266003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2366;H:akshu-HP-EliteBook-745-G2.mshome.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB2366;23:txQ7oAcoGb1h8ZvPEXCKrBN4l/V1f31zTm80YGp0w?=
 =?us-ascii?Q?ZFotAgbotUn+H4L7ovD8o4H6YQDRy0hMuWi5A1N2yZCGHtR8tlLRcQP1dnyw?=
 =?us-ascii?Q?HVlCGQ5CmmklgvCHuKCKzVjKuzTmnuzyEzN8XpHIf1jPyKWWBYji2HRfKRjz?=
 =?us-ascii?Q?nw+4McCj5sxAklBZibXDfV5r9kmClwqRaT31TSkG8hdJCOpWo/rzkLM3pMbW?=
 =?us-ascii?Q?rQ98y6Je386gQ8c1YEeYBdGjSJBVE8I940wUFvprYt8pzePDnQw6PMQ++2np?=
 =?us-ascii?Q?bjXVzWxdY59exyptRzGcNPB2yLTaot/u+Zk6OuujlX//mp76Zmp91u6sqCeJ?=
 =?us-ascii?Q?QKQvStn2va+76hv/ldcoS203gVqAV9cAsUCEtXGQ5XIWzRooADi6ExDugXpW?=
 =?us-ascii?Q?tvDSNSHiOszq0zSN8QcuRFl1ktdxY4tWHs5VJjllfAZk0xLI7esoZANNrntn?=
 =?us-ascii?Q?O34eMXAlLjz0dId5b9dVwUL3i18qXFYm1Ltbmadzz/i7nMuZ8ReRJrv5jAWk?=
 =?us-ascii?Q?QLQeZ2oM1VdPpRsruG1xw5DQRpSCSDeZgSPZ06aQB9BL9GKlEUH2rTnjk8JR?=
 =?us-ascii?Q?0dCV3gbcgRrNI7FTwHDYBSuh6/pudDpqkJsk3MEOyH1LjrWpQgjQVnhZD7uv?=
 =?us-ascii?Q?XWvdr90mBY9tY/0Pmrd/mPd8vD1Q6y+ac6taTgz8kFQoHZSMFyGJeR8NzjBv?=
 =?us-ascii?Q?zL/tfrT9w0hXX8uiR2Qt92e6sOFRnjMm0bdruywOYfmQ9Ps0sQ2GaOkRYbYx?=
 =?us-ascii?Q?cafQKW6qPoG9v5dKXQFslcjj9OdViwpQ2cKBP5VLFPqQbCbejumol7td9NHI?=
 =?us-ascii?Q?aRgozRc6I5PiwHWTraRM8ih91B+0UzDXr3TPWmKVD6m6hBy1g3vypR/wtna8?=
 =?us-ascii?Q?sGB1xF9MTqeHKGvb5Jpa1ytdN6yMVX8XF2yG+/q3qFFNoras6wL+2Ut4Dm89?=
 =?us-ascii?Q?9ebrLOICum4+4wzXAMsxzjLwuxP3JnQXAScGazQ1UArzqySjEIijc5UWOPjA?=
 =?us-ascii?Q?jiHlwq/bZG6Hf6nopPIUT+lVNqoBZsyu9rYdtkDGsPFS7yDM9uVjbKWaXW/l?=
 =?us-ascii?Q?JM3RWMBODjpLPWvxnJK1KbUpoNHtVgxgWtfN3772UK1LbTUmnXvI4FxF2nhz?=
 =?us-ascii?Q?P0YG4YWe6ewrqjz9eoDWUZePvsVTG/MIzd9dYoEyT5azFl6P/E+iX8rux+8m?=
 =?us-ascii?Q?RdDTlByqgdsyLtMQEnsxcbLHUtq05BEpXuHt0sw9ZNMOiIR3Ts7kv5UjID7P?=
 =?us-ascii?Q?qaA5pgccz/RmloyrY2GK3+aVXj10bsSCAcNmKQYGZBMxyb/7dxV0zBWAUiIv?=
 =?us-ascii?Q?0OBR92NiPhxaRZWQKLQdPW7sOSgbZasNsu3qr5u0pT55Llq5NIEC8x/p4e19?=
 =?us-ascii?Q?EqjfA=3D=3D?=
X-Microsoft-Antispam-Message-Info: ImXBUkIF2fIKToxYwM7ZCTB9WjM9dZhcaK1Q/uTiuj6FvQGjvXsoi7U/UNUFwG+jNqETezKP9MmFSR8lUYwfRfWSgAmJ8fazkdcP1Q2tibJvnSosKqCZoI5i0rPKAJ97mi8i/1l7u1s75JJgNMyGIQE3vKo9aZJY5f/pitICTlJBFCB1VEjLt9Yeq7r6bSA0
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;6:POlFpYD/SFgkHHm/gaUGE068cenOKyVPzs6iirY9sHHOJsr7WjNNykPyXURwoGNHpDEKsajBhr9AKUG+5bJeO5mvJ1fiA9kCeekU6yJvS1rQXvDZF4ryT5fJ5aAVAs5TmzqWLfl46E+FncFqBrnosMHMtPJKuliAuS8U5nCnmBPxpxBPgEaIq3mviu7VgQig/GVIXNRp3AOSNad8lduVIiFKEyyq23J0ySdS7i847ys428r3VoQeYDOrVflikIqgXFRSSDx4R/HEG3Ve7ZCrX5mxqjXaDMla7mgdDuAkb1NEYrYpbeIqQE200hvjhDvUkVTklod/O2lvjC7jaqqQbS3wvcLY5t2xe+GMzpWXFPFhrAlwKov+55UwFEeCNZudL/0d3l6HJcs44+tTZi0BMo3zjULBcCymnSoEBtqyjs46SWxAC02n44ViN9m1c7hYT0vQCHLYasp5SyoXh4Tinw==;5:NhTtP2CWoUIu2XS//SY5kZ6cmwRGvHYkyq7Q+3buynV6xjWdZhC9vdnnYMeFzuGyJHRdgHqk+ouTFAC6SamNH2WewHxVq+e9EfsN3t0ZYWIHLM9vPbX20Kc8gg7a6DkB/jh5864++4bwe1g0s3+DaWbxR/HQD9fTofk+2rUTI/U=;24:6swhweO7wmxJsXxtFarvcYoApa/lEOCG5y0Dc9skTvY0XdFQS9n898LUw7tWWRi3TaQApFxFFtR6JrHdaATbPXRUbxqUfdbnt94sAIsgWBM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;7:TQMn2B753Smnv8iTx/WIv5VscdzXXz8wBMoQKIQ9Ju59TsaZYQKKuhT6FGi3LiXFb9gfnW3TiB8k9wwOZBIROLdNEzNK4WY9xKaQw4MrYYn/2vzqFprXb772bsGx/jeaYnAo+7G3N/EW7Y0hp81uVA/hzpM9pLq+Esp6xY4Gpmwzqa5DEFoSjIvdN53Hxb28hLOxSw0TeA37oswBZ6KZlzBy5tDD7m6tlNynzqdjyWxKWbjNN9ARa7657TOsXnWC;20:w9f4jo32nHiGTYFazawKxgGz+D8dVd+L/4lSkog3XDluqUK+HknF3dXUsLe+2axrfIK6DVaR0TEEtImgmWoOMhiggZPi03PQZqG5Kp55RoTp5J+e1ZVIYuJKlYBA+xIsx0GkgnA3K1Fz5jjpb9/lYl5YvMBFiPNeU3wHTE+FNbRLxWfgSYjRYnmu7VTRicxz/2mmEn5HVLKSKmGQJJatyFw6aGaH8AoB8HZ9u6K6uPXonJE3XYCft4S0lWKoXBWE
X-MS-Office365-Filtering-Correlation-Id: 9ed87ddb-f7e6-46f6-e284-08d5b4038620
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2018 10:15:53.4690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed87ddb-f7e6-46f6-e284-08d5b4038620
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD ST/CZ platform provides a general system clock which can be used
by any driver. Registration of this clock will done in clk-st driver.
While the ACPI misc device will create the required MMIO mappings
and pass the same to the clk-st driver. The clk-st driver will
use the address to enable/disable and set frequency.

Changelog:
v2:
  clk: x86: Add ST oscout platform clock: v3->v4 unregister clk_hw
  ACPI: APD: Add AMD misc clock handler support: No change (v2)

Akshu Agrawal (2):
  clk: x86: Add ST oscout platform clock
  ACPI: APD: Add AMD misc clock handler support

 drivers/acpi/acpi_apd.c              | 50 ++++++++++++++++++++
 drivers/clk/x86/Makefile             |  1 +
 drivers/clk/x86/clk-st.c             | 88 ++++++++++++++++++++++++++++++++++++
 include/linux/platform_data/clk-st.h | 35 ++++++++++++++
 4 files changed, 174 insertions(+)
 create mode 100644 drivers/clk/x86/clk-st.c
 create mode 100644 include/linux/platform_data/clk-st.h

-- 
1.9.1
