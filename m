Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37469C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E3F20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sBEDqk1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E3F20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeINIDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 04:03:23 -0400
Received: from mail-co1nam03on0040.outbound.protection.outlook.com ([104.47.40.40]:45152
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728150AbeINIDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 04:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U08u1IA5SF92FhmImQ3k/zxzTsn7r5xSL3dNlhgLIuE=;
 b=sBEDqk1V4q8b/Mt6dW+IhrgNvu8tqfymfyqOUtQzXBpWlYT9S9zoYvz+rBC+kQFW4QHSrKB2AGa5rnxBU1VkiEuvyONuuVDsnDl3B2uQNENzwTAXa2pRAc9LWEZK3yL1o4B1XLRG/lJPGh9Bxzhdw65SxZcSIF18LacnL2JTBs0=
Received: from SN1PR12CA0114.namprd12.prod.outlook.com (2603:10b6:802:21::49)
 by DM3PR12MB0747.namprd12.prod.outlook.com (2a01:111:e400:5984::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.17; Fri, 14 Sep
 2018 02:51:04 +0000
Received: from CO1NAM03FT022.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::201) by SN1PR12CA0114.outlook.office365.com
 (2603:10b6:802:21::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Fri, 14 Sep 2018 02:51:04 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 CO1NAM03FT022.mail.protection.outlook.com (10.152.80.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1143.11 via Frontend Transport; Fri, 14 Sep 2018 02:51:03 +0000
Received: from hr-amur2 (10.34.1.3) by SATLEXCHOV02.amd.com (10.181.40.72)
 with Microsoft SMTP Server (TLS) id 14.3.389.1; Thu, 13 Sep 2018 21:51:02
 -0500
Date:   Fri, 14 Sep 2018 10:53:19 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] list: introduce list_bulk_move_tail helper
Message-ID: <20180914025228.GA17902@hr-amur2>
References: <20180913112208.1353-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180913112208.1353-1-christian.koenig@amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(39860400002)(2980300002)(428003)(189003)(199004)(6666003)(486006)(305945005)(33896004)(8936002)(186003)(33716001)(54906003)(8676002)(356003)(76176011)(47776003)(4326008)(97736004)(5660300001)(68736007)(2870700001)(6916009)(966005)(26005)(77096007)(50466002)(11346002)(1076002)(6306002)(9686003)(105586002)(106466001)(104016004)(81156014)(2906002)(316002)(58126008)(33656002)(72206003)(478600001)(53936002)(39060400002)(6246003)(81166006)(55016002)(476003)(23756003)(229853002)(446003)(126002)(86362001)(336012)(426003)(18370500001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR12MB0747;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT022;1:gppVYuyqQte6GbH8EaQVmyFLUkcun8KrvbXwdir+/V7w3BniQg2Rvg9L6D9UxE/inzEZDiSxPsN+56NWyKt+GSlkc6kBa2i19WPTp1wjz9xbO8Kc/X8EONx89/bzR0lf
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 645facb5-f16f-46d0-18c7-08d619ece998
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:DM3PR12MB0747;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0747;3:LrP7ABRw3huL8HsgrdURQ8+vTZYVpERd0rwAcoTw9aB/30NaVntZipAsJUA0+CzsLAt2FYjo4vx+X0kSpGzlNNMajgoW89muT0at8ChoUhOYw1h7LfvoaO7HTmcmnz6QKsEs9qDNmOm06TK5dMqEgMA9ivcG7Zq+s7Jy8MRwQbIvlUGEmoUCAlgJ13gg8MUsJzTO970TaKPcrgH1jM7eNgGnAMNo9OYZi/POcTT0d55Vz069M8PXWS3hWRa7CRocl2oiU+sfGmidXg9SCOF2cvcjUeQkuYzWHr3oUsW3l3wsjky7XlbDHhiO695Ck0XJ6vy35nBisupiPmJbKLk09uKrcxmKb1XtjRPJAdmfjnA=;25:qP0GE70AlG5FsRtnxGiBvQvnSmDOyAd8pZVpfA+8eODvdiWvRIQKKG6s6pPeg0cnCP/yuyxdRulyyXcGtOD857G6rj8OvfiSHy7T3UKkqOjPDsez7jjvZ2N0WgvCquu+ZIQGK/kQxwyblM86YaOnyItt/UTwEaavfyrNZpNplEHB1CCQYrbwm+wEZVNnsXEtk+PdxZM1O8prW85wABcDnsgJYu+JYQ8ZeegPduFddF4fNDmoThv1X/htaXKFaQ9JIS1v8rQzSuMuorZBMQO/Yq+yL3aaZ4lHkwlQ5rqqx5XhLPFdxwqtqA25q6j8Kk2mz8Jqid/BoyuDQsJ8IRqf3Q==
X-MS-TrafficTypeDiagnostic: DM3PR12MB0747:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0747;31:Fp3jYTLRFJxkPjYrX2g0OhJEwPoo6Zm9+gfjNVP/fSfiMMYTn/yDyAq9sdj6dVAzuYm/+tABRChHpZthobwhC3wb3jvSBBgjxQO/srJsn3BMnUmSYbjG1XvQLR0Dsji0miC+/L6UdqhXc5Z7PrtS3D0XWEbVEyvx+TqdkD+qS+SQA8BelbMxvhXguAtZkLdo0w27QCwkIvWIAxjj0HXey2mWkPPwTi1oMLZErfVaJQM=;20:JF8ir05GjDCvlCQLVWXhiS5DEuUMCHLNv/UUhj0ufehSVVuc1HDp4oN2wSfkB0YMiVeTbG2GMCW8Bk6QxJMjpUdtbOC4MWjYIuOa/N8DUUH/Wd7VcfdU10NbOuNEABenu71cB8FdKX+TwyF+b1uv4N15EEn+vaXEwCIsPO4vHKqKGqzZxQVRzI7vEp+fNEFszFeXxVmXpmFaq0hrSLAJeFkBbFezybzQTK/R7yUcSsEzcoo+lHbYf3TpFX7+N6IGy4bKCXPrWCi20tF+VKeh92B9kU0Y/qqMezVNKGCJQ6OtdoVu4AD9OiSPnz+KbIY7f3I9FGbNNDmtkSf343/C+i0IoEm8fsHNRufO/Nc69I/qG1GW0WIiTzx4e48F/Yl54DktQto6dXRMXMxzQf9xweuWmi/gtp04ZKq4bwf2mGSg5HF0ebu0CAXgbSWCPfcktyoMYlWvteVUCTUUmHFsQmOw1HZgz0F0HoyBXI5Xn2mEJFgXOWRCCc9ECC1abk17
X-Microsoft-Antispam-PRVS: <DM3PR12MB074776273D8E68D3527765F8EC190@DM3PR12MB0747.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:DM3PR12MB0747;BCL:0;PCL:0;RULEID:;SRVR:DM3PR12MB0747;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0747;4:OYeO8xPjtCKD0nFfenbYgGDcC26mdHXHkWrZ64yb+nkG1o9QHFTRbz623P2vnldg6G0eFOWs2j07YEImZpiKuZOVZBPMgrWiqDbMii6I/6U8AFnITg6HEKVu1UCrCXKKLU5KNFROpV2Obyt4w1SH12Tnwa6t8+EMoxXh1rw4OXPcdqHWwFeDrQMwiwREKFY0q/6zqaA5n0/+Z2+b5dQMot+sHniJq+fBfqowqXvLdPYgwCkLXj0maMJDpliSzDtlrs+ryTNnqvl/GhHtQSjHhkpsKPM4z3S7VIW7yX+g+snDfZMAxomitP/jc5W3rN/tLz5Lnp/sG2LRG3i/pS7DlPKmVwFRSmNR0zy7/zJvLiM=
X-Forefront-PRVS: 07954CC105
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;DM3PR12MB0747;23:xykQw77v+SOq5clAsFULLCpPwgFeDcaQVZ6Y2yB?=
 =?iso-8859-1?Q?kx/CqHuccmD51JzZXddciHyLOhuljga/1Kd1gQZSzDpfr3vmr53LbfIvfK?=
 =?iso-8859-1?Q?WRKqIsOCoUap61efPNpzwI4KrVli7biBZR8tWhBQrh5+a0lSVHvsw7xhyY?=
 =?iso-8859-1?Q?GhkznpNL8PanTWceEl+FQLIOMl9x4yporu/axLz73l2q7c41u1Od+QCrDS?=
 =?iso-8859-1?Q?dZWecFqaKNypmIB9J194YMChHiFNTj1P6+Eg5vHQ/6/M9Q0ss0o8RFWMY6?=
 =?iso-8859-1?Q?HKuXysB5cNQXrUhCJSCWOErnLtoSJN2IO5k7iVpjklCPqRsvafj4QtULQs?=
 =?iso-8859-1?Q?gu4p4hAPuWX8SFclO8PRIdU+Nep6oT34izC2Mycl4Nk9ke23g7vk8djlJv?=
 =?iso-8859-1?Q?htXV4rNLryrAyaNB155fOM5GDvAvMcKNgXME0hztagHLJNF+m5qLwx8b3s?=
 =?iso-8859-1?Q?IeUUpHViuhqLUtTnjuWwRwLhSwhCo2mn6TfaVq++XHtov8+lNYlQx35Wun?=
 =?iso-8859-1?Q?1bKZ/Me7CyQlA01a/yhaKDqFsvB/BDPCS8FZtG3nYntA3mceTXs7T0mQe6?=
 =?iso-8859-1?Q?PYcYkcikd6GxYDtfK5qXNKh0HSUUqu7JqE4ui09JuB+FiLTSXSIm+22SC5?=
 =?iso-8859-1?Q?bc69vqShAV83Xma6YQccpZTXzl+0J092HZbxY610l+7cY4zfp9GZtZRXN3?=
 =?iso-8859-1?Q?0eZue6wA72ILM5rIIehi/3nRsuTlj83hxjXbKaTYlg7FIJtYpi6395ayjJ?=
 =?iso-8859-1?Q?kOeOtpmwwC51KE6fCP1zrrXUicdc3oPdCoCPBQp6tDEzTXXZfZjJOdOcdd?=
 =?iso-8859-1?Q?iyYXTnhx7dV+NJGDAVZStZzccLQciceS+bAej6m2PrSHcms4ECH0mgH8pE?=
 =?iso-8859-1?Q?VCKYPZIp1RLuAe+JJnXynoqJ/fT0rnipQevWYXfuHBywj0XQEYdwNz/l9I?=
 =?iso-8859-1?Q?N+Khf6OFzQHwpIBN87qAdtBIUuAsKUN2YQgAHwrewiB9zHtgpo1yzVTph1?=
 =?iso-8859-1?Q?1T6yExlm93j/GLQ8A+cJCpkoysSaYIQpI2JPVYniK2glBmxzs+2nBjb9y9?=
 =?iso-8859-1?Q?OnJfAA26A5RnODtEgHbVD1O4IV6X0Htt7BBN6V9+tx1ZOzSBsaruw3cCg1?=
 =?iso-8859-1?Q?Q1WBjp5AL/hZqHpgiv7NqV7xAJMs0d6rSqvTkIFiz+E/lVB0VvSn4CfBNK?=
 =?iso-8859-1?Q?3nOJx2uHEU0AOLlp50OtHD9yooeuzKpcGXHwG9JzFsBY945bcAWY/T37Xa?=
 =?iso-8859-1?Q?jRjeOFq1TG2qu0c39o1C8x9YSJsxYwtx4yQo7Ua7YFRdTQj/+Ld7VVp1v/?=
 =?iso-8859-1?Q?U3FltjCTemBBrNrBRhFcfexAuiZBpgj2PsF2ynvc0Tm8q/+r9psLWD6YcR?=
 =?iso-8859-1?Q?nuYsl23FtpYjg/tFenDov86/0PdR5?=
X-Microsoft-Antispam-Message-Info: HRf7XAGyA7FYPlznnjOz4osh0DXP26U2oo1eb4AgtGFoSVhPYn2nczCUWvvgC6u0JgN+Vpa4voo2Us0lDNXTsFtv2Sn1rmwyERvb+FzvSkGB1yXgxSQ7G/4BF1JVLY9qN+uyHownmWVviVPEa2nNqKe4g8KnPdxhGcrO8+f75wFneKVvIlSe3YbL64U8PYCdYIDcrYeUgCRCU0c1a/lwbncwSkMiMtLS6i0ba44AzgPNsao8oAPXWIDLLmuWeQ+j2DsqPUZjPgLuMj9X+kg9wHVhHyJvwUIIDywkbVdWmlFYL4gSYirTFpabVUpzWkeWdczD0o8rVd+0FinWJAS73RsL+zRA4zoMoWacr5I6yFQ=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0747;6:MsSfMTvpAjnt+3SmSzCYBPa0uKTbuScwmRslGzCui/pWlOLOtkwwg62w8k2Dj+yWJU4Ybfk/U1D9gF0ZbjBbkP+QnAN5T0oLVw+TVw6MtaGSeRHiUQxXqQ6q437diSrbkiI1Y7FM7Uyz9XW2PNz39SjXOQixZfeV5UpKkEkvbc8Y0Tu15wKGQcQtmaxVIlsEPCMUW2zyu/JXmo5ENGrSlWiD/Jd/bl5chlyE26pRyww9BDM1GoYCQgwkMFE0Ta72Z/kHbZeSLK1J1Ni0lzAhMZFdMsNsdTUJ0uTZ6mc2oOTjDeHjkB5l9wfIaD1WOU3QVEXceRt8ikwCX7/FPMlZc0a8zvVTmp/op2UZDRdFhhW2ofEGTZTKzTKgKx9+YprBhCD67MGh8gmG6uGKi/zmIwgoamVdK65hwPW+bwMfnsdOpudN8PI4w6fAiEludZbPkrsoNgPUA+R2QEIoG2gcCg==;5:OdTfaJQOVJk+vHJF8pqoGRkia8QJKXNmDBLWJPchYxquKJK2g2ayxEN6ElzzCwCFW8gnR52ls6VxrKUVk0dIMM13NIf1K1nj2uBnBxCgy+gOsxFILcMKKv3UQ312kqklwhdOSKFF+YOAa86b5zzY7dzL7le318RKMoyDfj4gQvQ=;7:tcet00inXbVttlsKg7vE8PhLbkwPPYDL2taUMVztmCSoWsB+OakBx7jG4GjxD+kRTxFY8VfOdvM9GYRopzC9/jGGx4mEMpGVgRvJKwKIIvFIqKS7NT8fJ7KZ/8j+dwJ3wZafKHI6PQgiaTrTUZ3If3IHOzWSQGQXr59Z0NYB1k3xISFAc2iVLO0yWs4j2tqlTAPs/1DElO+s9pp5FilKLKAGiMek1MQPLJDP+iK0fw9WLEaDd8CfoOKbEz822zBY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR12MB0747;20:35Wb7Yn16u/RkTcYSlBrrKaHgf8TctbPzU9Cvvh5T1komoN91J4Anvgqc+M41tN9hjM93NE6WrFBN3M8x7HcbmZ91fRasSWGWXL+jH4J00lEaHScQyin8IfHW74MCNwqoRVumOHoNa5sAJrUsPO3HOOYn0SS+S1e5iY6tKjxPPPgU0td+gjnI607a8eIQv05h3LuXXLSA2S/6Dl0cIwFnPdi4D9+ujPQzcycUWwGaOVjmF5O1HRk8bATVM9YQ1Er
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 02:51:03.9351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 645facb5-f16f-46d0-18c7-08d619ece998
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB0747
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 01:22:07PM +0200, Christian König wrote:
> Move all entries between @first and including @last before @head.
> 
> This is useful for LRU lists where a whole block of entries should be
> moved to the end of an list.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>

Bulk move helper is useful for TTM driver to improve the LRU moving
efficiency. Please go on with my RB.

Series are Reviewed-and-Tested-by: Huang Rui <ray.huang@amd.com>

> ---
>  include/linux/list.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index de04cc5ed536..edb7628e46ed 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -183,6 +183,29 @@ static inline void list_move_tail(struct list_head *list,
>  	list_add_tail(list, head);
>  }
>  
> +/**
> + * list_bulk_move_tail - move a subsection of a list to its tail
> + * @head: the head that will follow our entry
> + * @first: first entry to move
> + * @last: last entry to move, can be the same as first
> + *
> + * Move all entries between @first and including @last before @head.
> + * All three entries must belong to the same linked list.
> + */
> +static inline void list_bulk_move_tail(struct list_head *head,
> +				       struct list_head *first,
> +				       struct list_head *last)
> +{
> +	first->prev->next = last->next;
> +	last->next->prev = first->prev;
> +
> +	head->prev->next = first;
> +	first->prev = head->prev;
> +
> +	last->next = head;
> +	head->prev = last;
> +}
> +
>  /**
>   * list_is_last - tests whether @list is the last entry in list @head
>   * @list: the entry to test
> -- 
> 2.14.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
