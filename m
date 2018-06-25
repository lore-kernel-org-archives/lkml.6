Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4693C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE88254AE
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Ew7cJK6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE88254AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeFYGUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 02:20:11 -0400
Received: from mail-eopbgr700059.outbound.protection.outlook.com ([40.107.70.59]:43112
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751752AbeFYGUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 02:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asCGtNpw5dQjd2uHtN3iekF6r5dm+YbiVc8mZSUVuNA=;
 b=Ew7cJK6I/hKywCJp1LRCEIF800QkRPOQtgO4g8fODnkj3v+/ozl/0BTvy5HMR6TCbrLWm47m+hLTeAhYV/+qFjWwIrTn4SBdXsLog2Wy+BY3DMgfNoIxrcTq1nto8nbo3JEHklJDr94Xkk/BbAeJnCSIeSDfGyLcbKZ5FWiW1Sk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
Received: from localhost (78.187.48.10) by
 DM6PR07MB4379.namprd07.prod.outlook.com (2603:10b6:5:bf::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Mon, 25 Jun 2018 06:20:03 +0000
Date:   Mon, 25 Jun 2018 09:19:50 +0300
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Joseph Myers <joseph@codesourcery.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Andreas Schwab <schwab@suse.de>,
        Alexander Graf <agraf@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Andrew Pinski <pinskia@gmail.com>,
        Lin Yongting <linyongting@huawei.com>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
Subject: Re: [PATCH 04/24] 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T
 config option
Message-ID: <20180625061950.GB23998@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180516081910.10067-5-ynorov@caviumnetworks.com>
 <20180608173207.nwoi25jee52gpdwy@armageddon.cambridge.arm.com>
 <20180609074227.GA6810@yury-thinkpad>
 <CAK8P3a16ByPtCwKbdLQRDRni3qV9DXLNYZ9QJUH6uHaZYHr34g@mail.gmail.com>
 <20180611112736.GA19952@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611112736.GA19952@yury-thinkpad>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [78.187.48.10]
X-ClientProxiedBy: VI1PR04CA0087.eurprd04.prod.outlook.com
 (2603:10a6:803:64::22) To DM6PR07MB4379.namprd07.prod.outlook.com
 (2603:10b6:5:bf::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88060487-33d3-417d-eb7e-08d5da63b0cb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4379;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4379;3:vh21SeuE0k0/g1JLtsl+Bmu4Yo8LMrzwr+MlErWDiV2ccT+gFFqJCy+5XIpaGcBPpsgjJop1JLa3UIVA5+laoowQ21ONIJJCa1a8WYEI3yZ+13vp/A6wzF73cErO8YIIUD+QYshYiaD/e+1lI6zJWAeK6HgdN9fsS7+DN+pINSpJHp8ckEis3BIr+AH5+mA0LJRWfkULU78dt6zzjLqT82z2LDIyZbizT0UJbsloBotqoMkC/RyxhHs5cr6c1QR4;25:T65kbMnFXY+7t0hJfZa4mNqS70i02DcxKATnJy/AI+9IxwR2bkCIqEoaLSi3d9a8JNYjZoX5/5AZzS1TuiX6mRECBj3L4OwkTothaTvt6j5uyp7eDOrrBO2+wtd5lt33J78J4pbMMeAMAvNeY3HGkgk1b/KAxuf9jmby0Ag4WbGKdyFRkBx6Zh+do3IRWyR2I1rz28lva0M8npJWhWI4SMEFG0EOzRjlNREbLjX2xOIwK9WU4HMKo4UjAu0r8Ww2j/K3A4I+NzT06ZcyZu6rUanYcpjl9TsqxEXpgMhbx7HyskN9J1d1OeHsTZXT1Jpii7gkgR3vrFuzcqszlDAgWg==;31:Oa1dqWUn/EXmnE47k8ZKIbL45iZJc+r8EZiJRkMUigZpgjvxG9tCSXbUSN69DcT7P89LcttIDpVrt8K37l0W9y1hAESe8AXd0ZMu5rQe2Y1orkPyc2eHldbiCdTXtj5JpJRwY5pomatsSbowhighCUfE99/EQ3auchaPS4+Wxo4SO2H8GZSuEoVRJOP6edAKjIknKypR9MJ/1ZNFG/osnXr//8S56Tf0PMs6FOUjXnY=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4379:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4379;20:w7l5+IIVhRl3MRLn12p749Q2X6c3jkkPQ0ctdJuYfeOdD5YUGoJ5hgGRHytGKLTwjCJE0hhiZNdBgtyTOeQGN6VhnWWJCSLPn5hNdz4F3veDUEcATg5dk3HCSZ9ARu3QINyafpKqtiFocHPUN3pHhslGxWaOF300bxaOahj2pxiM5ydWx1RoGfohZUi2US/nlgWdsT+bXjgm0j7/q70cM6qXwiTOVIImUMeoywmjWDcfWR6bYYUOX/iJViro/DXclg7J9Nsiuy4Dx8TmuZE6yuU0LyiVAfQdC9EIqbPjRsdiVsf0EZ9o39lugh018Z6uh4IZiVh0klXudUTH1sjBttEOAAXNQT0IO+3xFdzA2kWqj+aLXKeVIM+8F+wfvzRuPLauJfxqpH8Lp7Co3O19SX8MnzNxenokwn5aUGfJ8x969G9b5iJ1cvWwgrrXLH/oWhy6KV3+PN/9w0nMMNmU3jtQ3N1fPWkpB7WoYTLt93Iitn44isNnN4cC1DVGXl8J0Fs3bLKVx2Cy0N+VXBFbM4HfusOtFZuJASGwx2xjGbJ6pBXjl/UPm6uDqU14kN+TFqKhmBNdI0pd/15KYm4DrAcqcmmwphjQKeAGngL3zMw=;4:Gy/fIiY3S6WPASIBtJxPkMuHI1xF3WejCRL7C8LiRiNfNKh8aLSBap8xxqPf3fHLzJpSmoB1tvTp03KnxaCjbGfqyxxVdRWOl6ve1O13Zs6OEhazah7YNPkOKwaE9snUOEM8Ik1k36puhGYUdeby6leZxA+2pZUkuhAmAw5qd4456yewBo9fOXZD/wTD35wsm6+brrFgyJ1eFnahwtWSSWjAkVegzIBljlH6bi+kVN5BSwxPtWHCJ7gVwsnDgZpfM/oNKQydQbmZ2Fnjoc2Kqg==
X-Microsoft-Antispam-PRVS: <DM6PR07MB43799DFC43008B42269826ACE34A0@DM6PR07MB4379.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4379;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4379;
X-Forefront-PRVS: 0714841678
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(396003)(39380400002)(376002)(366004)(346002)(39860400002)(199004)(189003)(58126008)(16586007)(54906003)(53936002)(956004)(486006)(476003)(11346002)(76506005)(446003)(105586002)(106356001)(15760500003)(81166006)(81156014)(8936002)(5660300001)(93886005)(68736007)(575784001)(305945005)(33656002)(7736002)(7406005)(316002)(6916009)(8676002)(4326008)(229853002)(25786009)(66066001)(6246003)(6666003)(39060400002)(42882007)(7416002)(50466002)(478600001)(72206003)(9686003)(33716001)(966005)(6496006)(52116002)(23726003)(2906002)(6116002)(59450400001)(97736004)(3846002)(53546011)(76176011)(1076002)(386003)(33896004)(6306002)(6486002)(26005)(47776003)(16526019)(186003)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4379;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4379;23:C6M+GxN0clm7Hoz97OpwkxGqiSRcPjvPwN89fP+w1?=
 =?us-ascii?Q?2d330jIJbyYsZHUjV8m14LOOAQKcJwuhj29b2Jiz2/IAAd1Es8Tc7eYhIUGe?=
 =?us-ascii?Q?qFwpZUNmXdC3TWf6YLG3Z6AJoAUIg2Omf9CTdqpg0Khq/WBERrauR8z+oPR2?=
 =?us-ascii?Q?8aTeQY8em2rWm6+r4T5FHqCttPkbg8OpIcBvCvsFvD3Y+Bw6HSpPTtsDWu2M?=
 =?us-ascii?Q?aQIz+x5gm8sNkSGe/qK13jmRiZvvdZXAQ4Ccq4wHO30XcgJ1JMukk63WcHoL?=
 =?us-ascii?Q?ru2oiQPyDuEf+HaV44W9m5BKwe5BKt5SuwAdeHCsm3tTHKloIx0eDAdV5fNd?=
 =?us-ascii?Q?C5HfqeuAViKbvimtPPzUg+hQHaOdKuVEDHDEwCt+2Q93HWM5vs/m9Pgj0cF7?=
 =?us-ascii?Q?BSU3pJdMeayOv95HpXVS4BFdZdrbP47c1gb17Z2L2RbdHbYStGiDzvWDUAUK?=
 =?us-ascii?Q?a+JzsrmBzjEzomL9JY5ZDMfA6P4lX8OGwoAM3NGOPkYuqvN/n2tbfCXxaxFG?=
 =?us-ascii?Q?Pu9LVBsINlRXYn+NJXefo9d258Xogpk9e+yTjSfvvhOrFMpJnzzheXcU2Tx2?=
 =?us-ascii?Q?yvegvRSJfZez/csMHyUrQcv41Cbgjbmo7ynIgV1clE/ozHqYoOgxk/+Rq7+U?=
 =?us-ascii?Q?qcPXQELrLoHC1eV3T1SJrAiJjirMG7PigFhl+g9twzvjrYpQF988zux/gg9F?=
 =?us-ascii?Q?lKedkjAm9Q5MN1Dndc0m65IIklV4Ir3yi5jA1CqCoUnYb4wrkFtRbdU6FFH7?=
 =?us-ascii?Q?D3uA5BAlRgtrW/1VZWr93K/pyurSpj/MD2LtYKnkmrMKpe2Sto4orirPl0fl?=
 =?us-ascii?Q?KOQ5CW7cd1W7W1y3jEdyqYXYSGYLd+EN/mXCAXpBj+8KkrdM1/U39kxO++2P?=
 =?us-ascii?Q?cU2yKpqckEViemMHla9z0AobePHWY35plQE05UkB2v+cvs5j2ZgJlCFJ+iTE?=
 =?us-ascii?Q?yoH10Oy4UyyPUMht9G0zqvLL3NeaZX2OftYnop0Wgfad7xBpo6c4Q+cn7JIs?=
 =?us-ascii?Q?YOvfzYyNXEpqdbFIUagCe+LOiYmrGV7DNi6l1MDd3I1YQNrcTITFl+c0KufZ?=
 =?us-ascii?Q?jq3yuSl46Ws6wC2rqvxN18YfZXFx88tqwdjB/ZKyNzTY3pUFNjsCUmocHdWn?=
 =?us-ascii?Q?WfeIR8YqkvQZoYBLE8DvzP67uuCPPQnAI7D+Eg3ko9s/suC4QpS9fDn/Bu7+?=
 =?us-ascii?Q?YxF53bHnmPsOAsuL6QW9tiy+Rk0pni+VrzAggHzthK/cBeEMUIXxKwPf99ZK?=
 =?us-ascii?Q?nUGjSz7HKr+626CmSo13boX5xADNUdNKz2AzxGIIl5fq4NkiDUYAuqzuZISB?=
 =?us-ascii?Q?eKzY/FFyQrRRiEFLSZQtR2d9dq3YwIH1QKpb9sKQYdZcaFjwBW6/FzLSZLpr?=
 =?us-ascii?Q?OUjA0mPBh8++FdISOOViN/bZ7X/x1Uice7mJkEREew+JXTpvnBlWuj9g+MbS?=
 =?us-ascii?Q?mOeoU4mjOE5/HIcyhqqxX2xyel77U2JIPs63ixJr2NgFPbXn/d9E/wHJdi58?=
 =?us-ascii?Q?NOgbj4JRazy55AwL7QxJhYmzLrXgIDY288bOkZD3yDKiC3HImm6hj7rA+x/u?=
 =?us-ascii?Q?V9ps8j9l9C0KIujr773ownAHnBt4m//GmZqTHHRmBDtnZqFt3mIJv374Q4O?=
X-Microsoft-Antispam-Message-Info: xzqf2lMAmiGHP2A7WjD51SCk5HF0eSwa6CfvpuWoghgYJKn/0o3RP/+t8Pbo3rDvyVuqVCpClQdB82EDMnvBchbpgt+Vr5pY1MgcRR0vDzAXJg8iY2XpbjvAux34Dwj3PR6YX2fxqCm9I2AYwMyoTGkheAmQNINZtbgauFKsJrZ+49llCkrPA+l/0WYGJqQ7LEdL64wylw7ff/KLhiUbbvT9MSU3FkX4WYw4673PwbyjuvOkMxqn4kZsBG9RbY9BaKrJ9sv/9PcYwB6YfTOTAcrY65ipx2sVbk+/JzzM7JtWayKvhT3sHPTMqK0d4hRfGdQLlgas+es63wx7kANYb1jR6rM0XHlN3ZyVNqeePIs=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4379;6:1J2YsELdX3suC/UaacI80c70fPFtidcvoD5EFycNuCyFtblJkgQsLtYUE/6Z0t+rM/lIlDzkVr81ckdqEHSMH92fvsnp7/ieB0QKuFj0cKik/IMHKZHfU1lBJBHnpdKnFdqPlKUDwmqt2P3CtXszLfMJ+MCTTsIQDiWX66McJf1fkaYNavAbNZrQEQPWerXphHjI4o5VlcoV3cE2ImgKmJgjW50Zck931opeVtPiokNx3Tv8Xndr9ikI4tflDLX/NidY1wWR/zqQpJk7Df6TRV6T3xgLdiF77TkvyWABptlR934QsMvLbcrhvcdwhhJLhurPCOMcYujRF/3OE39c/JvyS5RsAxiqyh8tb/WiBJWI3nkMiKvcPzNMNGxIL1FPfEVeZIHEMEJ802jCGXViEm3fwG6tPFDkankxwkVeg4LWFv8Sss1eU7nCCXscPg2Qep2uXF7kGlcM+t7bFRUJOw==;5:w6dUX6sO7SHgrZ9g0exeLnBFuRb2IRvgDSJ1MrIiYN4GYqYwOkKkO1p5e8k30qkXwToXDJkUnLAGGHeOWLXr4QBRHTtvxPqg+44nGpFoWhZ637ov3SN6+Sh07CyK/NMBWWFFq8V/3zrWtLp3m+VIpMS5tByJ115oYbur9EfN6Ig=;24:GY/6l9tzJcemQRmzlxnVgkJTRo17F/Qo/IA19odiT7H5PD/TWmof0FMUVi5/4k/mRX4SZHuoxRMtqAl5tema/zrd7voAq+7KR/YVU7V45eg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4379;7:k9BpYmjrbNjEwpKQqsEBQyF8uT3WKlHj8VYNw6DBNJtKBOeeODwjJFF/PxjgUS+JC0F/62QsM5Om4WrbQfkfXZXp5sxK2ex8uuc963EmHrX3u7MGPnlh8auU7BcPz8MBFyRmFEG5FDd53cfFELWzP1bpJHwxcV6amAsel2oCn+kNAmTLmY4ZFRO70qF4bBraoriH43jFHyq2Iiz91ELBBSYwwxC1cdqaJblaos5TORxgGOTXfC7bTRAIcNV0ZF1g
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2018 06:20:03.9400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88060487-33d3-417d-eb7e-08d5da63b0cb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4379
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 02:27:36PM +0300, Yury Norov wrote:
> On Mon, Jun 11, 2018 at 09:48:02AM +0200, Arnd Bergmann wrote:
> > On Sat, Jun 9, 2018 at 9:42 AM, Yury Norov <ynorov@caviumnetworks.com> wrote:
> > > On Fri, Jun 08, 2018 at 06:32:07PM +0100, Catalin Marinas wrote:
> > >> On Wed, May 16, 2018 at 11:18:49AM +0300, Yury Norov wrote:
> > >> > diff --git a/arch/Kconfig b/arch/Kconfig
> > >> > index 76c0b54443b1..ee079244dc3c 100644
> > >> > --- a/arch/Kconfig
> > >> > +++ b/arch/Kconfig
> > >> > @@ -264,6 +264,21 @@ config ARCH_THREAD_STACK_ALLOCATOR
> > >> >  config ARCH_WANTS_DYNAMIC_TASK_STRUCT
> > >> >     bool
> > >> >
> > >> > +config ARCH_32BIT_OFF_T
> > >> > +   bool
> > >> > +   depends on !64BIT
> > >> > +   help
> > >> > +     All new 32-bit architectures should have 64-bit off_t type on
> > >> > +     userspace side which corresponds to the loff_t kernel type. This
> > >> > +     is the requirement for modern ABIs. Some existing architectures
> > >> > +     already have 32-bit off_t. This option is enabled for all such
> > >> > +     architectures explicitly. Namely: arc, arm, blackfin, cris, frv,
> > >> > +     h8300, hexagon, m32r, m68k, metag, microblaze, mips32, mn10300,
> > >> > +     nios2, openrisc, parisc32, powerpc32, score, sh, sparc, tile32,
> > >> > +     unicore32, x86_32 and xtensa. This is the complete list. Any
> > >> > +     new 32-bit architecture should declare 64-bit off_t type on user
> > >> > +     side and so should not enable this option.
> > >>
> > >> Do you know if this is the case for riscv and nds32, merged in the
> > >> meantime? If not, I suggest you drop this patch altogether and just
> > >> define force_o_largefile() for arm64/ilp32 as we don't seem to stick to
> > >> "all new 32-bit architectures should have 64-bit off_t".
> > >
> > > I wrote this patch at request of Arnd Bergmann. This is actually his
> > > words that all new 32-bit architectures should have 64-bit off_t. So
> > > I was surprized when riscv was merged with 32-bit off_t (and I didn't
> > > follow nds32).
> > >
> > > If this rule is still in force, we'd better add new exceptions to this
> > > patch. Otherwise, we can drop it.
> > >
> > > Arnd, could you please comment it?
> > 
> > I completely forgot about it and had assumed that it was merged long
> > ago, sorry about that.
> 
> Hi Arnd,
> 
> There are 3 patches like this in ILP32 series that change ABI for new
> targets. I've submitted them in separated series:
> https://lkml.org/lkml/2017/9/25/574
> 
> They all seems to be acked by you. If you ready to upstream the
> series, I can rebase it and add riscv32 and nds32 exceptions.
> 
> If Palmer and riscv people will decide to follow new rules, we can
> easily drop the exception.

Ping?
