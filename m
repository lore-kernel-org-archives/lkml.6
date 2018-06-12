Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8638EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C4B208B5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="ar0dmH1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C4B208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934238AbeFLPJv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:09:51 -0400
Received: from mail-ve1eur01on0088.outbound.protection.outlook.com ([104.47.1.88]:40672
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932803AbeFLPJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuJ9vVu+qxYGzKW2LyQgvfeov9EVV5qRaKlQBS+11oo=;
 b=ar0dmH1wIdUsifkYyU21jW4O7EQYTFNLwnLQ/+fgI7v7JZpOAoh4rtynHd6Gr+QBJe2Hi7SqeIc2j+KzoISeXqcV27r1ap+aDEyLH8pJ6EHcZBrDLQ+S2BYKIWmudwWxWXhaEllLK9kE8LbzjA0iCRmdXwpj2E8oNml7G6Qv+QY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 AM6PR04MB4664.eurprd04.prod.outlook.com (2603:10a6:20b:1b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Tue, 12 Jun 2018 15:09:33 +0000
Subject: Re: [RFC] Configure i.MX6 RGMII pad group control registers from
 device tree
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
To:     linux-gpio@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
References: <f5a01de5-fc81-52c1-c2ea-edb77ecff076@ysoft.com>
Message-ID: <5ab5c58a-dc44-d1bc-2132-8704d05bf1de@ysoft.com>
Date:   Tue, 12 Jun 2018 17:09:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f5a01de5-fc81-52c1-c2ea-edb77ecff076@ysoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM5P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::27) To AM6PR04MB4664.eurprd04.prod.outlook.com
 (2603:10a6:20b:1b::23)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4664;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4664;3:RYBAU4vPQE7IuZMGARPWbIIGHLpr5XuWRVRGMt0ip4V9rsRAD4OBf868uA2GuScq0k3mBHhE0ss+mjj/X6myBaYuJAC/PlTXbKRQFm7cbAuIEc8kmMjwikF0ZfBsh6AOQ4RrjqHVgUuevR3XOXXyocUdSWxDtxTqdT/P1TKbJnOi+m5puvg4BT1Nqw0OdxIJ2eHxs/JgWtyNny2Hj1CGFlboEoelS8jrFCkjc2eFuB7aI3Gv6ubP++OfntZ0SA4B;25:clpP2qp1coPux3VH6E7c+9LzztkgCrBBISBnKA9a6HGJcDZODOWsoUKH6eZ/n7YhoTKk2TShVwnA7WsiaGAZ4DGJu/ZEp93UcQmGhRGOqscwoh/4yeo4KGymFEdRNjG8hkKugwSjSAC8xgzZOYkkcswABWHtfAFJE8n7AYki/gnTzu8hWqtgTb+rA+ipkHs3l2yJKBLmIzaTGC71F8jv6pkg1OkgHvTIUeE9YX/nGgltdp2YCzidmTGhk5AmQv5yZ2ns7Vr3T8y53kT7sAj4V4efAg6rakUMf1hO/RCPhmSPR9QlBGIBfMMiRZ+GhLyBnZYadszlbNbonJH0dOEhLg==;31:NguWNIYl9tsW4TZkXoDzc/NPErAzhA3MuEMPkBq6oCbosa7amVCjJX0/e6J9I9riiNGwlOpI1ySCpgA8eIixIsCQurxABwl0bM+mDY56oPAZBBS1QV2dCwW/U3eab5JV5pu3CLMF7gFRHWm1iQ7cumbTuNMwIE3Nv7Uwvv9U3AXAlma826CFgNyzcyPl/YrobmSYfs7BEb7iQONnsjpIilXwJA1rO0LPQcEOvMWoxP4=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4664:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4664;20:ZPSB6OjN0pqVMqBp5yZ07ZW1wrlZ0wttzymAucEHcala8l4jWNIRHm6fvFqHqa4+ZvIt4cWVj03bmq35cIw+u3UGzR++5b7Ev/pwhYzcepgfkqGl9mKP/Q8J55+nLRWnxEmd3w51ue+UnxTXnStcIHyxlmnw7nUp7+ccEstt80Q5PFRnLJ4c0Wqlvwj4eJuoCILDLR325H04UCvCcn7Tu8NA4oi6iMBp3MdzTIJTyLEXHHWETD33BYsBLyd9AnSj;4:XMTcPunH0gCoPeLdtLOwd3h+CYmIPVZLFwVDDQBiGNC0tVC1Cz52FUq1URgosB9A0W5RlFT+0tTlyuIrFvVlsUInflqLOoK+EXmZXSlnyHBOMU1aQ51QTowb8GjVYkz12qsGo29XbuU46AIaiIlF84EzGocbhaYadGQwl1892sfW/QfvlcI08LgGIayADKhR1xC/x4Z54ygTDpIzYMr3qSH1DCuOXbv/DcTSNMrV1kUQwGNy6Ilg/PKKOyEXHa2Nmrnw8/LIVh9KCKVDXUHFuMF2YnuyV3IeDKVeE5NGp05ANvxiOJs93WeuiUWdiRiQ
X-Microsoft-Antispam-PRVS: <AM6PR04MB4664E4A41A8F7920A6A791859E7F0@AM6PR04MB4664.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(6072148)(6043046)(201708071742011)(7699016);SRVR:AM6PR04MB4664;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4664;
X-Forefront-PRVS: 07013D7479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39380400002)(396003)(39850400004)(366004)(346002)(51874003)(199004)(189003)(76176011)(26005)(86362001)(386003)(7736002)(53546011)(77096007)(316002)(16576012)(59450400001)(58126008)(6306002)(305945005)(85182001)(52116002)(11346002)(65826007)(97736004)(5660300001)(66066001)(65806001)(65956001)(47776003)(486006)(2870700001)(50466002)(956004)(186003)(476003)(64126003)(16526019)(446003)(23676004)(52146003)(25786009)(53936002)(4326008)(106356001)(2616005)(2486003)(39060400002)(8676002)(6116002)(8656006)(478600001)(31696002)(54906003)(8936002)(72206003)(31686004)(81166006)(6486002)(229853002)(6246003)(67846002)(36756003)(81156014)(3846002)(7416002)(966005)(2906002)(2361001)(2351001)(105586002)(6916009)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4664;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI0NjY0OzIzOjFlaWw3THVZbU14RTJWTDRObTdzMWZUc1lB?=
 =?utf-8?B?TEpIRFlObVM5SXZsZkN3Yk85SnVZNHRPM0JNRWV2UC80QU5HczBScm8rY2Ey?=
 =?utf-8?B?eXhvbzVUNW91V1RDVEt3ZnVLTEhJMmh2RjBnZ2NJREJhakFQY3pwYnI4MTY1?=
 =?utf-8?B?UkhKVFhTS2ZlaUk1KzBYd1dGeXJ2SHpQL1liYzcrdFVKU3VDTWVxLzQrak1F?=
 =?utf-8?B?UndWSmV2ZTNpclVLSG1IYWt2RWxkK1EvUUx2RGR1MWZnZERPTHQzZzRnKysy?=
 =?utf-8?B?cnpGUGwwelRXdGZqYmd5Z0srdkFMMmVMNVJBazdPU09pSVUyMzRZeXZxNnRD?=
 =?utf-8?B?c0pvWkRqWDJpZDZFb2pPTGtnTkFlM1hQL3JYRE43dHZxRUtyMEhBQnFmNHFB?=
 =?utf-8?B?OWFLODlkbGs2OGpCcHhVNjlkdklvY1ZLUjdmMWk4YmJPRlRFRUdqamJVMkdv?=
 =?utf-8?B?ZUw5ZlhteFhRWGovMXd4TTFQRlBiWElQMW1tUFh2ZitVVkxrbnAzUDhibnFr?=
 =?utf-8?B?ZmhNWGxsckh2VkVUNHBDc3YwSS9HczYvY1lBS2RHMDAyS3BJdDFqN2c3alhH?=
 =?utf-8?B?YkFJWXBrK3BDUzQ1bmRsOVpYdWJVRmR1L095WVZxUmE4Qlo2cHIvVVloZUpJ?=
 =?utf-8?B?S3kxWXI1VnZyS213OHZpQWVtSnRuZjhYR1ZwSWliM2J3dHkyOGZFd2UxbWR1?=
 =?utf-8?B?aEZEMDhyVHBBNEVrdzBpOVhjd1Y2U2FlQ2xlMTZjQTh1REYyOFF1MzFOQWl2?=
 =?utf-8?B?TEtFOTJwZ2MzL2l6cXM2TW51U09JWkh0WTlxeEtyRFlRQWJkWE4wdjZoYkhM?=
 =?utf-8?B?OWw3N1RKdjRqRHI5Q3lEenFoNXdlaG84bDVDRkVremY4Y2pJcnhNZlZWYXAy?=
 =?utf-8?B?Q1ViQlQxQUJHVk1ndXFiQVozTThRNS9SWC9RdXl0ODZQUUlPU1IvRHJ0KzRP?=
 =?utf-8?B?K3pmbXE1cFJjbmxhdnZWc3VuZzRnRVhzT1o3RUNpNW83dG5xVEQvMVhsMzhr?=
 =?utf-8?B?QUdTR2gvZGxlTkd3QWRWNGdZT3FaR0Z3dFlzQ1lRbTloQVI0UjlQYlZuS2tB?=
 =?utf-8?B?VzJsa0pOWmtEcE5DVWxQVUpzQ2pRUzdjR1g0WC9kMVQzSlNiZ053RUFQb1Ro?=
 =?utf-8?B?Z2J0eDFHOUVoK0RQLzhJSEVFeGloYlJESVRpVlUydlduVTlLZkh6em5BTW9Y?=
 =?utf-8?B?d2lLRkRDUC92eEVSc0FZcHhUNXlCdTFpb095cVZCdlhwNFNTK0xYbnZ4Ky9p?=
 =?utf-8?B?SDFWNWdEbUczU3VYTnIyb2wyNk54aG5XZWNaRW9XNHhGcitDanRFL3BoSHdn?=
 =?utf-8?B?L2hCT0VkZDdVY2JBbCtpQ0dlZmxvTjJoNXl2emZraStmUXcyZlMzeSs0T1lU?=
 =?utf-8?B?SWlOZnIzbTRQMEttK2JabDBxUlYvSUN5YnRSazhmbHgxd3J1bHVGSkRrSHc0?=
 =?utf-8?B?eHNnSVVZeVNzRkZqMHJRYldSczlyWTZrN0JyblJ0ZWQ5TzVaWHlnbFlVQU8y?=
 =?utf-8?B?MmhaMjlxTlNuakoxYloxOThBWjZ6MHlaVC95YVlEcUNnYi9YUjFSNFlWaWxj?=
 =?utf-8?B?ZjJJb01PM2psbDF0Wk5ObWgyR2oyWmlnWW9ycFJOU1Rlc052ekRBVWVvWFNt?=
 =?utf-8?B?ZkRHeERNUFg0amUreHVXUmo4T0tEdXliOHdBMDVEVTZ0aHBubTB0dnAwTmxQ?=
 =?utf-8?B?TGpIVENxT05SRXB3Y0xwOS9YdThiRVZLU25Ib0RzU3BnRVVObEJFeDdWZVA3?=
 =?utf-8?B?TWF0bkNGbVppTENQVUFpQkthdTl4ZWdYM2krYUZ6dHQyMUJrcXJnK0hCWTkz?=
 =?utf-8?B?a3V1QjNvT3Z2aFQzVmdHOEtkbWd4Y1hPUUhWY0p5YXFPSnlvVGY2MUFmeUxa?=
 =?utf-8?B?eTRpcGdPUXR2TEJhNXpxMCtFS3Y5QzlNZVNMeXpNSVRBQ3UyZDA3ZThLN0xH?=
 =?utf-8?B?Si8rZHlYYXpmMW1FTDc4N0tEZERrZ0ZpeDFrc1F6UmM3OG5JazNiV1VXdm9x?=
 =?utf-8?B?dEdhS3BmSUpWcE1hNlVJZlcxYnAxaDc1Y0FIRzI2UlIwSkZIWFNyUGg2eEhl?=
 =?utf-8?B?dDZrU20yQlVlWUFGV3VrUDdjSzhoTWtlUVV3VVpOa1FwdUQ2NW9oaitHMWJT?=
 =?utf-8?B?N2ZuRmRsTjI1Q1JOdTMwa3BoQVdsV2RzNTZXTXQzUXlNeTl3RjV0OTRnYlQz?=
 =?utf-8?B?MWx1MXA2WDUvT0p0dm83UlhPdVZOTnNvYjJaY092elhic3diWGtVMlEwSmps?=
 =?utf-8?B?c3RkN3JkaXFqQ0RLcXRaVFc3MkI2VnliTnRYRXRHRzAvZ3VWT3d1UT09?=
X-Microsoft-Antispam-Message-Info: rbsKSseaVSI4zsrsboHWU7kHo0ISX14EtTaXrjU6nQRhlmHjBy7cd5zoGL9kwCA4lG5W5L/76C9lToCBjtzz4B1o3gDoC+PKoyyP28QF7HBJ+bXxEdKB7UjG5uFIvtSbDRyK42bQDyrgzpl+vYwMhM3RAA1DBGZe0C9v4/2tvdUWcBX2z+hqTPye/FtXANLe
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4664;6:PL0qNZcil32oVRCdPdq+uIAcdshmgUukG9UBjAyq6uJ0I82AS/R3KeDawsVP0cGlOT7RqB4r5KBn4BUZTO7zjwQiGgSI+bZTerFtqVZU7YrPO0qUEGPViLbo3twRG7qFvkymxLim7U3Za86K/PloW5gceJ1fU1VWmCv7uOkQ4H4K5gK/fFwBm6rLvSINtHSIymjIjIgyOCh9YNxIJN4k6ItAODhwVOJYXcAuR/OakS5hQ2wV+DvFOzbu8uEYI9i9VtdYp9QE3HiJ+w7bFDLcCvXxnLX1HGdQ1LvkPY7ce6NL0jtUdp2AvoR4OnuHMTczT2E9qui6vLqyUrZhWwAX6jW2lDg0fvTiPn4sW+gOCgkKIc2wK6+bPBFmx0il6DEfbacdb8jJrVg0gR13xhNIjhkTehOwHtFPKECNfSGq4Tvap5jmxLeMbvCnNCNE7+isfxPbotfnSs/MWEi7wMAFQg==;5:XagQ2h5cr14pApVma55jhnOypg2ClGFXHDBh0R6QwZ6S+An9FSl8DInlyFbxybhMLwdQ9Hy6mp7vy4nuliqelRd/qQSJ06Hl8o1Yps8W2uKA2OcKy3JVA/jwHAbSeduQdOh5C+PyMtU2vZ2xTv7hIxd7OWhlRte80F9/mL3R0S8=;24:XNw3jGy2KXllHwnc59pDOEybazu+2mkpBYPQ5ahl4MI5Bb+8KrtDqT2zlW+F5mZKMwFxXdBwUEIeXEIlt3rfrumxVM2OZ1NLsKJPEx6RjaQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4664;7:4TEhMpmBViDz2cMXwJCXLWhFRA5M9x/ArOLvlvkzlfXfIPQC+XN6wunZdfkTkscrBFekzpxzpc0/OXKhbBbsdQ5WonDmZEMnKNeC/umAb1ks8xr2tEH6qWtLfdl5uJ0Xx0BpQ1gH7SNWkmFuTc9nQNqX0jNoXQvKXQbPxIYOXvtfvFLUaIUFXK3e/lv8+tmf5VepmJMAp8hS0uGTxQucNrwWpRZOBCq79jp/QQYscqE6lqxow8dwURO1yZM483Ll
X-MS-Office365-Filtering-Correlation-Id: e9600a1b-fea8-4c1c-4b69-08d5d076881e
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2018 15:09:33.6939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9600a1b-fea8-4c1c-4b69-08d5d076881e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.6.2018 14:36, Michal Vokáč wrote:
> Ahoj,
> 
> To configure individual pad's characteristics on i.MX6 SoC a
> fsl,pins = <PIN_FUNC_ID CONFIG> property can be used. Is there any convenient
> way to configure the pad group control registers?
> 
> The issue is that some bits (DDR_SEL and ODT) in the individual RGMII pad
> control registers are read-only. To tweak those parameters (signal voltage and
> termination resistors) one need to write to the pad group control registers for
> the whole RGMII pad group. Namely IOMUXC_SW_PAD_CTL_GRP_DDR_TYPE_RGMII and
> IOMUXC_SW_PAD_CTL_GRP_RGMII_TERM. The group registers in general are not
> accessible from the list in arch/arm/boot/dts/imx6dl-pinfunc.h.
> 
> I could not find any other way to change the group registers than hacking-in
> some lines into the imx6q_init_machine(void) function in
> arch/arm/mach-imx/mach-imx6q.c source. As I work towards upstreaming my board
> this should be done from my device tree or solved in some universal way.
> 
> Any hints will be much appreciated.
> Michal

I figured out this is more "pinctrl-imx.c" than "device-tree" related
so I am kindly adding maintainers of that file in hope somebody will
shed some light to it.

I am diving deeper into the code and it seems there really is no generic
option to set the i.MX6 pad group control registers from device tree.
Or am I looking at the problem from a wrong angle?

How should we deal with boards that need to configure some pad
characteristics available only through the pad group control registers?

I also raised this question at the NXP community forum [1] and get quite
unsatisfying answer so far. I would love to find/implement a proper
and universal solution.

Thanks in advance for your time,
Michal

[1] https://community.nxp.com/thread/477464
