Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945E7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF2B2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RJja7hif";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Y1UzqJjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF2B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbeGMXDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 19:03:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39178 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727482AbeGMXDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 19:03:53 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w6DMiPE3029318;
        Fri, 13 Jul 2018 15:46:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=6UvqoeBktTkmiYOHTBS5rN4CW/6z9AWfCPnvcGQe0qk=;
 b=RJja7hif8f/3RQ8LeEOdSeY/DFTWF8qqCU1uGXEUFBmFhfiZtR2cNVO5KPTGUkVLHiBY
 oa8keuc4F++jHEf9aEMLPUAeB1X1vF+4jBle2z/vktEtvRt7feuPQIlZStri5yyFmx/y
 8HvkGaN2Yx8hgbEkUGb93ReOTTmMd5aBSVo= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2k72p00cfs-17
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 13 Jul 2018 15:46:49 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 13 Jul 2018 15:43:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UvqoeBktTkmiYOHTBS5rN4CW/6z9AWfCPnvcGQe0qk=;
 b=Y1UzqJjNprYZ5UmDJQNmK6p2csEiHb5tGOl7w3Jwo5nR/QOJ/zwfUf05UQwFSLk4znmXlo/x8AS+klQcVti+5FUtLyYF4dFSbmwyG9geJN9/akbKaaymtD8zQgPv3WCqKOdGPs4WrMx6BfgA7j86SwxwdrjgpwLU/Z54Ita5oZY=
Received: from w1t1fb (2620:10d:c090:200::5:1164) by
 BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Fri, 13 Jul 2018 22:43:44 +0000
Date:   Fri, 13 Jul 2018 23:43:26 +0100
From:   Okash Khawaja <osk@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 0/3] bpf: btf: print bpftool map data with btf
Message-ID: <20180713224326.GA5941@w1t1fb>
References: <20180712030803.875913594@fb.com>
 <20180711203010.51bab0cf@cakuba.lan>
 <e938c861-b341-22f0-7e82-215a27e2b74f@iogearbox.net>
 <20180713213550.GA5667@w1t1fb>
 <1e80f262-9b3f-e4ff-0e89-7a07098d1b50@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1e80f262-9b3f-e4ff-0e89-7a07098d1b50@iogearbox.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [2620:10d:c090:200::5:1164]
X-ClientProxiedBy: MWHPR22CA0034.namprd22.prod.outlook.com
 (2603:10b6:300:69::20) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e909d20e-f6b6-4920-d44a-08d5e912179e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2501;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;3:6f4y+5l44ygqM7y0CEui8KjrQPAMMExha0hTazLdU19osSEXxgZ/x2XmAImG2EEln/euBYF1Ws9ro+HkEDCjAzaBuckoG65SWfYBKjSyftNXBb2198YknquWNZrjUIIRGYKOJvxV94slx43wSgIt4J+44+ZF3//trFMYAXlMjRCIbN6Rkkp65CK/kmkusE94wJ2LU7O3sucvMswrw/DpAaoPyex5zzCrDjtKQLky4JjzZKNyhTg2TNLxvdwJT5jw;25:K/vu/g6NbkkJT7FtKoRNQ/rh+RAikupBEVwQkOnrhsr22rA0Nj5XBJl4D6tQvTCFWmbJZhE7JLpdZdTRBkNNiqSNp6it/FObLaXHXkJBmIaCRCtEqA+99lxL/JWAcSuAKKWmkfxiYSYfLz+LQQfftGSNZ8NM+5UycJZmarjciQ/kEGnabep5Ci9+pvtTDjd1e2H5wSzq2GlZRznNzhn2y0FlWRfkGO9/okjFKsbC+A63+uen+e1+AMZByjyM5Tc2RDBx+v3terqF84GvyCJ64JqjXdxC5JqVwVHGNLskyqGCoKq4kVlUFfu4pdc0h1Rcu2s8ifLAjnLdnxWZ8uo0oA==;31:DmOZ/HDVMDhx/tPdwN/YCanIMRjtIjTkoaApnTkgn/qvH3s5e/kULVGlBO33G+mLBsYpIB+g74SnZUIDktfpZhCkpMtz1GJa7YHCBTSLWG/2tMGMgxYbM76msauS4gJTf09Y+pVD4Ld0Af+n6zsleW4eFGG1O+VM/jNc42RdymMfMkWcrTrehQ6Lie2wmB1B2LbqBOlPCHbg0rs1jcIN+lxjjXcKNqwNKRHexGJLE30=
X-MS-TrafficTypeDiagnostic: BYAPR15MB2501:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;20:Q+jO6tZXgJ1oyBWFahb+4zw+2m4ReoLSflGd9fI7oayyNFL2/5KKaurElia7z3ZxJmH/HArDDB9imNX7Ww6BrWUqA+WN/9EIDh348mxxjAvrwaIzgXoUZKXQeV1l6RAwa8u620ZYTTtqX79DOrLFMXOnMK0cwB1cd8PdqWcuQt+DJtNGXuzYcPsuH5tSdTrPwDpm6JWIhulJlC1BGGOpquGK1oG0Z3WRR9HEstErS4OeMkmWVAqM8e8wwFwoq2AVf88wR25+sMicXasyHUOvlWLIpeR8SJ8jWzdwb2wLqWvuBBgbDgdfPCr2cVnzYfxqeuJtGLJvZPnJQcJJKRCiboTFhJs4IBUyDswVHUew1bvvtOTLuCOpMG2z9wFXPQG8XS7SEjl9FH6raFg2R4o1F4BhZvTlnHN8NQR8nEOJyqYWwJFlxzmLJCTUZheY3rEzWbb1LOk0PMaT35Pwdl1X/ZiHo7G2lWXMFamEqvWQpxzmcqNkrAmxmrFA8on3FqSG;4:qrokKFyorE3NclK+SaiQlU7Z3ruypbzh2bAgancwkVBR+F/IydNEw135+qg8HcewZkZq/gSqbXwA66Tl/ESqodxblxjIL28A5ckVeOUalsdJ1H1tIleYA56SnjL5S/JEoEf/1qd1h5GLvx50RP0+0RSLut3nGbqVZajRffQZQOjZJ5wCzmvdxU+yZR1IvAhFWlEPZXdmQ8qn0wKNXkafpX8k5nrJFCQ158UFWJ9UtQPMj1lZLHVqw6R2iVRjz8xhpJZcJKyb0z9vGZKOcl07FVObfe8t2ZTsbE1JTDUk3Kbc7Wo5gtxvExOz467rFPxx
X-Microsoft-Antispam-PRVS: <BYAPR15MB25018F8DDFDA6DDADDFC7AA7C6580@BYAPR15MB2501.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(10436049006162);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BYAPR15MB2501;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2501;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(376002)(346002)(396003)(189003)(199004)(53936002)(16526019)(53546011)(486006)(6246003)(5660300001)(46003)(39060400002)(4326008)(6306002)(446003)(186003)(76176011)(5024004)(476003)(9686003)(386003)(52116002)(47776003)(16586007)(478600001)(54906003)(11346002)(966005)(316002)(58126008)(33896004)(6496006)(68736007)(50466002)(52396003)(8936002)(86362001)(81166006)(8676002)(23726003)(6116002)(81156014)(106356001)(575784001)(105586002)(7736002)(93886005)(1076002)(6916009)(25786009)(229853002)(55016002)(33716001)(6666003)(2906002)(97736004)(305945005)(33656002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2501;H:w1t1fb;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR15MB2501;23:aFozqa3MVHdSK98/PRId18tJrHgz86mqVAllSuVVn?=
 =?us-ascii?Q?5YnafO6RP2us5HzIcMhbOXo2SJFyE3w48Lqy6gMEVBWvZ7BX5lgM37pwQF9f?=
 =?us-ascii?Q?HUrKESuXq6rOiyQynjVYONGIDlksptS+QK1xy2mJ0M0goZ8HGaq2gSBUhFb3?=
 =?us-ascii?Q?Xdb870IRF4521Bz5TvVOxV/tTkz7+eSsOzFV/rD66RccYruSrirqWs6j1glZ?=
 =?us-ascii?Q?BeUW2A26mcH0mpuOU+AULMLaGWTArW+ZUBMQW508NkUnmrVfYfVw5/rKYZ1n?=
 =?us-ascii?Q?0+Z5OS+C40SNFQDKtwa1+TgEjup9X7tGk4OkJGId5wsUhQrUifz3XzKof+sX?=
 =?us-ascii?Q?btZGYLFtYwVndTxbF8TjI4f7YEC1HhI5e3YeafnrcLrTfRS3YNcUkCUJ1VRz?=
 =?us-ascii?Q?WYieSqRTU60UvzUnW1OYKkpdAR2L7KIHtZIP71tQ5jemH6korUvCVZJeMgNq?=
 =?us-ascii?Q?2EWI0rtZyul3mQ817gkHX1PCLmviMPDMg9lt0drXk3yXbyFoi5YVKa2ZtrYn?=
 =?us-ascii?Q?TnYMSfdwShMkxq5b3F9cZSL/3lpDpFj3BsLNbZsyj3pgQQ6TpKWgNXCUqaa/?=
 =?us-ascii?Q?Rirym+3IeJOPm2GxoYrrHBkiddEG0v8LEYf39R1TBmySfw65sf/TGJLRqeY9?=
 =?us-ascii?Q?5HwQ7T7+s4D38CLx9xcf8XNj5TXSQBMN5nXOHYbEyuewV2fiX2txmwkx1oVV?=
 =?us-ascii?Q?zSpCsAYT0RoXoDnPVKJSYKcTsjMpyFBN95gCnj8ePupR8wpeSi/WS0ICO+9E?=
 =?us-ascii?Q?Bh/REGYqDf9oEkXeVRH65ZyvH5MZxx82q/aOe3k81u3sHXvloGXqI5n4tcpF?=
 =?us-ascii?Q?nB4qPD7P8Oa/+X1XOtXHnuKhTVSKR1mhYIcV26V+R5z1EaO2pMRipNM76Vth?=
 =?us-ascii?Q?rb2v5rutVHWpcypc5ytf5atWrOUBqcLvoqBauiIZriTxKB4J9Gb82UW9EybI?=
 =?us-ascii?Q?k3jaC0FMxpXitmC9BourxyesAqjO0jNdXqa8aDGZT9c+/BA29qS672u9Fv9h?=
 =?us-ascii?Q?qgRn8akrDExmc5tx7tvc7S6gEJBzBznEk3kIcxsAn/sCNuMFxLdJw2LXTUU8?=
 =?us-ascii?Q?Y4lLD3K9irwKLJRALbfXaX0YxXhA8sbFpem7FW24Xk6LWQe3s7G/crzh8DQg?=
 =?us-ascii?Q?ZMpcezsG9LLZGkkhD54/7jroXn4+Bx9hg2uRSotl4Q7ymYIs3rdamyPQHLLR?=
 =?us-ascii?Q?WY6PvemPJWJvAg0q1wLO5mTqK4fOm5iv0Mb8RCDjwsRZoZ9Lwf1amCJfjr/v?=
 =?us-ascii?Q?mx4LWO2Zw3ZoDK/UyMtQCcAFqx0EdwO0pox6KwOTseW5xgqzSNLK6WMc/i8O?=
 =?us-ascii?Q?yEaNZipoAvas1v04R+t3/696oWpRW2G2LlKxMlTijmbFunbbLoddBU+QZT6S?=
 =?us-ascii?Q?iqDbKLGNl9rmiWwKH1HoP3xk0Bu7lWajOd3DPsN6uoiYWpRg8NiVFkWg1uQD?=
 =?us-ascii?Q?ss4v7UD9g=3D=3D?=
X-Microsoft-Antispam-Message-Info: dmFCz1ZmvzIn80R6HoLmJj0TJv0PTnC+69c+XnaPXYSbDg6W4O6rC03OIiNJA1nhjImqshWZ0UhkiCY5+I6b4or+EHeSXg1M73yZSO1WIjmTF1msJs/M3QdyjIa8NWtYLauioqGPNLfZcEz+SVQBcozoY/uoufEWg+gOC0yKHLPsarUixyXxGVof6+D/0zHHBSd00qJasqYwHFXOp5kN1XHMb9sdCHiv1MqCAne2V4Y5gkJvOh1X1LU/G1Vy7IgBV76nC9ucmoiC9jnYo6JeXsb50Tj/40BaQQDZYOcQ46w1NDouLUlKmCvJxW3vxYfNXgJkSl9mJWTdcmhgepRdjE70DuceUh6woOTJoKcBGLA=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;6:XUMl8mrQINfM9yJDcsNdb/z3ViIq5uZn0H1WAsd9qI9hYh6VjiT1vezIbIHuqUan2vblKuyj8f97gWhRICvDuxMTqDu0Jatcaa08aU+USR2wX9PVxsMa8AlvGoY8PJy2btEfi1SBFr+JX7+lDTKEfpVHb0CQu1CHHItarJpnt1i/f8Si05U2ieIkhnA/1xGlEaak0sbvNWPMCqeHz99FwRYtGpY2YbH9Y4p8knXXMHFvVtOoY3WpUsrUXzKpG77E8pBdYLa7jDJCVnlOW81Z0IyvX1IELRgCFktCruCfMn9V6Rfr+6iKleOHqE00MkuIdYjZ9YGPyUHHLcBv1kZzeXAdc2L5zGz4Pb9GQbVZEs2Im2PTyCxIolmU1T3OkHe5yABbGT/XO8pHKYgdlTYwB9Iaj+Z9AADNJ5E0n3o22Cvy2/yztORpRsvKxOMoufTDBv4CjXAJFFKUQq630MnE8w==;5:SzZodTtQ2iHfVb2llgr+5lm82gp7X/sCIFxkt3kCub4GWnczMamnWZv5sqGhRbb3VTTVyCaGDdhiplhxzjTdToZWWbd7BGykCnQIxA8krvl/ZcTgADwkh6dhtPPvvNR8BpV6zk6vdBO813Et6qvYKiWOwMqcr2SCuYyrQA7n4ZE=;24:kE5EbTeFax9cbC7+M151+agTsqiJ4WWQiVibg+68YJoP2dAi167aytYFZSIGZbu7/vFK+vxm9r9+y2DnPEZtnlzJAALt8ZgkYRv2Nj2nmrY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;7:RJNDWGcHkKhYvBcWexNV1RKkfql8uMvm3be0mQZzPnS3/7FcUAvxYhpUgvcskguxY3aDkJAkqJcQf6IdnLmCISyoMop73i/J1t6cIvFkBkbKq1Xq1eLMGt8PUB1svOVpDcjmQ1YZlWW24Je53iq1EyeWPnf/BtRy8WiB+myTs2BmLa+TWTM5mEql0zWznUHzPDkuEJ3Owh5XsFZawYSBLolKjctyNVOwTZdSSzzHXUi0TAhXHkdxumP5H+pKpvZA;20:AZC3g+5hKpPLajykcW3p/RMcbf3tlhHcGDq7boSphJMWqYa8A69yd1G1cQP97a0qPjTKRRoDfHdtjxLmE2aK8vZy0HOrvUBy9k+wYvAVIfMmuHZ9nIYcAT4juGvWbhvtgGRCx4U5YphhcprSz5nZ4EV9fmqu/721qvfn+D0ot7A=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 22:43:44.7761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e909d20e-f6b6-4920-d44a-08d5e912179e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2501
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 12:35:03AM +0200, Daniel Borkmann wrote:
> On 07/13/2018 11:35 PM, Okash Khawaja wrote:
> > On Fri, Jul 13, 2018 at 10:49:01PM +0200, Daniel Borkmann wrote:
> >> On 07/12/2018 05:30 AM, Jakub Kicinski wrote:
> >>> On Wed, 11 Jul 2018 20:08:03 -0700, Okash Khawaja wrote:
> >>>> Hi,
> >>>>
> >>>> Here are the changes from v4:
> >>>>
> >>>> patch 2:
> >>>>
> >>>> - sort headers in btf_dumper.c
> >>>> - remove extra parentheses
> >>>> - include asm/byteorder.h
> >>>> - compile error when big and small endian bitfields macro undefined
> >>>
> >>> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> >>
> >> Hmm, strange, by accident I just noticed that only your bpf fix ever made
> >> it to patchwork, Okash.
> >>
> >>   https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_project_netdev_list_-3Fsubmitter-3D74458-26state-3D-2A&d=DwICaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=4wHrS7MHHFLZe_WCJwRVhA&m=wkiBQFYWPyiN9WONHLY0WiZxcOwNRhXaMMLIE551mCA&s=RggQzClRdkwawboGLPgPXHOdUtYffxeOwlcBlFru-P4&e=
> >>
> >> Potentially because you've sent with attachments which got dropped on
> >> the list?
> > interesting because i send all patches using quilt mail, the same way i
> > sent bpf fix. i can try git-send-email.
> > 
> > also i dropped Acked-by as i changed patch versions. is it common thing
> > to do? or should i keep the Acked-by?
> 
> Depends on whether the pieces that have been ACKed changed in the
> meantime or not.
right, thanks. makes sense :)

regarding patches not showing in patchwork, i've checked that the
patches are not attachments. is it going to be a problem with
upstreaming if they don't show up in patchwork? should i send patches
again?
