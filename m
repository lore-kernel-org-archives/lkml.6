Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4DCC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341162146D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="QJ6KI9yb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341162146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeJAXGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:06:03 -0400
Received: from mail-eopbgr20089.outbound.protection.outlook.com ([40.107.2.89]:34896
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725777AbeJAXGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCVnEVjmTB53cCuJFHo28sCeWGdXMhptZQDLHqdH2yI=;
 b=QJ6KI9ybs3pCAQBaOghxtMdP+S4q+H6NSC3yz/jlX6/CKX607Sh6NZPdZhXxBITpG3o3EAXrB1IVgziR7S2d22gsZi7UAKBMuntU4NMNrJupz3wqivrCK4O9pFiFIN3GpmlOtC/3WIZxTBJNjoES/QGvaLlw8CNb9I7/mSEkxNQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 AM0PR04MB4658.eurprd04.prod.outlook.com (2603:10a6:208:75::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.24; Mon, 1 Oct 2018 16:27:19 +0000
Subject: Re: [PATCH v2 1/2] Revert "pwm: Set class for exported channels in
 sysfs"
To:     Fabrice Gasnier <fabrice.gasnier@st.com>, thierry.reding@gmail.com,
        gottfried.haider@gmail.com
Cc:     stefan.wahren@i2se.com, hsweeten@visionengravers.com,
        loic.pallardy@st.com, broonie@kernel.org, gohai@sukzessiv.net,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
 <1538400237-28766-2-git-send-email-fabrice.gasnier@st.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <156b0b28-a23a-b8f9-c8ef-67dfe31815ad@ysoft.com>
Date:   Mon, 1 Oct 2018 18:27:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538400237-28766-2-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: VI1PR0701CA0050.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::12) To AM0PR04MB4658.eurprd04.prod.outlook.com
 (2603:10a6:208:75::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d1b76a0-d735-4e20-5bd6-08d627bac252
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4658;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4658;3:QyyZsWvkCaoSWznsQpNoB9mQ0B+qnToEy7dcRlSclS5raui2RZcmwmaAPfZ1mnLnBedGZLjzWkbhLKXfcJX0mwLv1hK0+vKKv3Axxv4f53gUeE9a7pY4/POTjx2uXv4iB7XFuWV05G/+vdSvRuq0HseTFkyeHDy8fL0rGilM0HHIBeMxA5SGx4sktLrmgGvEmOuKpKmBKhHh6eTzGt23Gvqq7Fo/zLf2ZMXvyCAq7AJ2DpYB7uSAOYkxg7KEpbj4;25:EoLs3IECvqDGoqAANhZUsdxZHe9K277z5rqbOCSPlCZjvcBi6njuSrr9djLxKH21v6bp4K/feVhcWn6PIpYx4r/zbRmm8oULgqhAfjiO7aZzeIqhR52OgEogElyE9naiThlL4MygG7XGW4XfxMciZ5LMIa267StszxzOz33Ogwm9044H7LPnZ4iYgKOEOcUI4VlcsIudr39RnhsQ/gmc7/4hocuf3gYEghPp8ZhV4kGleN0juFOWrDXQYa4eq3jO6OJeMKA7lM/7R/q4T/SoJEw32emoi7zHZmm2EMmbLK2EuPuguiuvmZowVhO59IVcs4MaDJ7bZ+Wy8gZSJDoYLw==;31:RvmvNIy8W5Bw+cP8SNIO5uPhX27Es7yzmwSA67uoRv7nXMO2c4FtomisN7AmK6lUFt6jZRgQpjZ6kSp8LoUj12wC4hE95kkdEmtkq5GQ2bql1TR5BeQvvqjXt03C1w3vHAel+mR2bN/V0dEJGreeZa+foHAnXCHsFrFRxsjPPHnqqC6TbaZYB38EL+Mrj7wFtHR9mZSIdG+nMku2v8Hv/JvRIS1E54c6ct2jbsboNJQ=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4658:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4658;20:4ivldIFGSAcCLtHvFP3eAUFbIAAtXqryAVJs9Kmke/uKk1GobGaugUTN+z3TVdzxyz9Oly3qSzEoMGEuG9BDKyaJZ73/vRW5RBmVv6ab4RNmfNY7R/jp95fy/d1KgnU6OnSWvwS7Lx/Wr1kV/hp3NSmWHrUdGQ0Seey78Ouw+fBSuIewQLUOpxK55UB720nQ5UWgxPSP1YxGak5Up6PTGy1NJ0Ej2BGsOf2f0WM9wmbbIxiZ3635+siRC8+WwK8n;4:NMaVsbmtAG0AeVrMfPntFBMmfxEtWOydl8+4tqHdVM0flYEKVhJGmTp1BrehgrsAPTz54eZml2lc3kW0Pw/08rMI/PclzhJbPWa+g6Rk7lwyLdQg18Q4L3POGlAWjesgB699SJH/g0KomvbL9Azr4A+TIZv9HQYh2j2MTWTxMSC3t5xJHD54gy+Jd5DT8f+fZeLnmDd/Qox4ZwpKS4xmXLqqJNI9GpnLYqk13m5eiWstyceFUUwBKiwiZwTze55SJKGDC3aEy7rkBdZZkFSf3jHwmRsi7Lw7O2DNwwCwok0mRuKi3vTq+vIq/FdZRlIl
X-Microsoft-Antispam-PRVS: <AM0PR04MB4658D4F3D6AC668AB743B54F9EEF0@AM0PR04MB4658.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:AM0PR04MB4658;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4658;
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(346002)(376002)(39850400004)(366004)(136003)(199004)(189003)(229853002)(7416002)(446003)(4326008)(97736004)(76176011)(6486002)(2616005)(956004)(3846002)(6116002)(11346002)(2906002)(64126003)(476003)(16576012)(68736007)(85182001)(316002)(305945005)(6306002)(14444005)(50466002)(486006)(53936002)(65806001)(65956001)(66066001)(47776003)(65826007)(966005)(6246003)(34290500001)(478600001)(77096007)(86362001)(7736002)(31696002)(186003)(72206003)(26005)(16526019)(2486003)(58126008)(6666003)(36756003)(81166006)(81156014)(2870700001)(31686004)(53546011)(8936002)(23676004)(386003)(39060400002)(106356001)(52116002)(105586002)(5660300001)(52146003)(67846002)(8676002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4658;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0NjU4OzIzOlNoZU5NbEVkclNsczU3bFdqdmt0R0JZZm1K?=
 =?utf-8?B?eTRPcUZ2bE5wYmZBZHMrRWNnWkVGa0pxemhEOVhhbTRwbGx6aXlUSDN3ekZF?=
 =?utf-8?B?eGU5REJ1VHNXRTd6VHdRVHBxcW1RT3hIQ041NnRJcjgxWnA0Ukdub3RucUVH?=
 =?utf-8?B?WG9STW1xZ0ZXVlBSaGQ4dEl2eERBMzdFeGtqakphYnVPY3hvM2VqOEE2S2cy?=
 =?utf-8?B?aDI1OWc5K1JYSmdYUHRMRFNDcEZ5N1JsQVhSNDhPYWtsODVXbjVsZkhib2RI?=
 =?utf-8?B?TmJDbGsvTFJsc2xxY3k0TXk5aktRRU0vbkhSemdDMDZtdFM4TEIrZUFUckNl?=
 =?utf-8?B?cUVVK2FDWWx6WjBWTUVYSnUzR2xCUTdxSE81MDdWMERwWGNIMHJLbUczRkJq?=
 =?utf-8?B?RHJqeld1ZlNRVmkrdmoxYWRVVnJqME9GMEVta2ZkYlRCQUkwWTAyaG1SRlc4?=
 =?utf-8?B?Z3RXYmszMWZ2dGFlV2VBWStmcTVocGNvTTVLeWdEOVRNajFYVlNiS1JXTTRw?=
 =?utf-8?B?TmYyeXJuMVpxa2xMZi9mZitrY24zcWppbHBLQ2UwYVBub3RWaVVpRmxwY1FW?=
 =?utf-8?B?eVdnMkFpNit6T2t3dUJTcG9LdCt3WHZRVmVqaW1OOFJTdHBISmhDcE1FMmMz?=
 =?utf-8?B?UWlrV3NPZFozdzFzZTlKT1NyalNpM0VRNWV2Nkw0KzJyR2FZYnQzK3hEQWxZ?=
 =?utf-8?B?dWZ3eTV5Rnh2RW1MMEhub2xsMHZEc09Ob2FEbzZ3M2NKYXhZRUF0a2ptQUZn?=
 =?utf-8?B?ek1KbjlZMWpGVXNobXJUVjlnYVVlRm5qcjBHc2dONzgrZzZjbE4rZUhYT1Fh?=
 =?utf-8?B?RW55cUhLaXAvK01rUWtKd1RxS2pwTmZjUHB3R3o3YyswYUtlenhSZlNGOWJk?=
 =?utf-8?B?U1luQ2pLbWlDZndVNCsyNHoxUnZSSFJsU2VadmY1dmwzYWgraFpwTVFIZUJu?=
 =?utf-8?B?R2RsZXhtVHVHM0NnWUVLNS9WZkpEVTJJaU52Qm40c1JxbzgxMHdmaHJQVExv?=
 =?utf-8?B?cTFCbit4YzJxZzhQVmxRS0RFNWVaNGs1clR3VTJjcTlBUVZhbXRGV3REUzB5?=
 =?utf-8?B?dDYvdk5EbDdXTUxRUm40S1llNy9lN1RkakZlUUdXRFdXeDNHUGR1VWd6YWti?=
 =?utf-8?B?cGlISnlJMzFDKzZhSml3SlR5SmRQbk9zTGJ5WS9Va2FPOTg5djgrK1o0VlFw?=
 =?utf-8?B?YU1KV1JUcG1iRUJuZEQ2bThVSkxBYk4ybUgrckh1SDdGYkRydFh0WGFJUlpp?=
 =?utf-8?B?MzZuQ2NQeWd4ZnNPYldsUlJaSGx4VThhVjF0UHBBc211YURHaXVpMDFhREtS?=
 =?utf-8?B?QlU5N2lQakpURTZiY0F3bU1rVDdDWmJua3lpTVBFdFB0eDF5Q29QMEtYZUEy?=
 =?utf-8?B?dUVDc3lRNERGazZJVXN6RGdIUkJsWUhnRUtPS05tMnI3cGplYXR0b2Z3cnlh?=
 =?utf-8?B?UityQ240T2sxeDMvbm5TWk9qTHRoQzlFbmFmeWovdEFPYStDRzcwamg1Uk5r?=
 =?utf-8?B?NVl3dUtNZWxBam9SeUk2Ulp2NzdwRWU0cVdKRkw0djJ3RE5LeURqbFExeUpL?=
 =?utf-8?B?KzZpVjhXdWJBVWtkakQ5ZnZheE9PR2JoSjRId0Rqb0ViWlA0WW44c2FIOG9i?=
 =?utf-8?B?K05uRDFsY2lPVlJZMi9uZ0JuM2dUdTlIRVZjTmlCTlpWajJpakZlODBhNnlJ?=
 =?utf-8?B?UG5rRE5YVmlEZHdabVFXSUtORGRoWW9TZVNjU0hqSGt4c3dYczg0aTVsMWRw?=
 =?utf-8?B?QngwMzVhRWRnMFhPMWdzT25HYVMzTG9TL2V6bkd5WW5Malg3QzdpZ1ZQTlA0?=
 =?utf-8?B?cjA1Q1lsaXdXSzRUdlpic3NkNHhhYmYzMjFuWjhPY3AxajA3SDV6TVZML0x3?=
 =?utf-8?B?R0dyZDJwY0RHNEJDM0lKZ1dGbEttVEFqNVJZdm9TeS9ScmhGK2owcTFRdjVG?=
 =?utf-8?B?TkluWlhLY3dhYnpsMGJ6VzVMakczU1YvclozUWV0ZXM5bStRL0l5NzVEeHgx?=
 =?utf-8?B?THV3Umk2eEQycncxLzMzaGZac2JuTmRvdTFOeXZyclROSTFBUVlBbFFKbEJ2?=
 =?utf-8?B?VStZYThGVllPbzBMSVk4dWpvVXdLMklEdWFhMHR6SUhIaTlsbTNpRGdyUTBS?=
 =?utf-8?Q?k89Pl/41pJuRe+kRtX9tsJA=3D?=
X-Microsoft-Antispam-Message-Info: j5RNCF0Otk3BK7ygQ29XW1Cjn/AcKfwc8S98iint0nmfI6C3hJpMfej37uzTX8vprWAaX2onujpNIr4N2ZlpviChfXXUgfG/s56ErgVFYs4+oCaKLhML6DNlUJd8Q26I30CfJx4o5gRAh83c5lqTLOTOHJ1KYYIqjXNg15zOejnO4AegWrhIaeVc2t6aFpVH8znU+glJb5SBAkN3eQienEkIzDM/dPMEzK/sx5bliZsVHWXjVo9JLX1qXKu1M+vpwP9IRDo8CirpoGs8fCcaluiABLs9iB6lnydSoIDXW9l0c5Wbr8MnRPo2Vzp248ISqSl+tOin3XHSkVOygiU5WTyumEFuTiEgB6yqKwmQ2TI=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4658;6:BMfkIJ0rieiET+QwXrl3xJJaSi73q5QNvZPTBWuQlrPBy1TNVMIWxGW5U2j1S8wjUrBhLPo+vOIlWsVdT8Duw8bRNAx0OF3GuqgPmfGbqLm34M47H2V87+n2bu5l4Db03sJFwV5iEN6iOIagDOSyw7f2uEmdd6hHK6Ql7zi1kgS+7slysmmWpMVH+UaN4TPCGycX4vDEIeWRnXKosftRrQAuT2vgKa9JIsf7xaWT5eWecbEn7Ra2Q4O/E6izdQUJt471Kvqsjc+gJa8Qd/+sB531XzKLTvZ5Q9ZO/Sxd9v4znFEtROkhqnHuYcCdRFWMsHoddNVtpBhe+iJ1h3qUzLnRvV4eNPWwtOiAkTAMTZ/VXRaFXLDMtgrygz1yxujh4cBeztlDRXxQZR3lXuGGTmDRhEcXS0OAQjVgpfgbZELV12Bn14GfpQGMx9S2eyv9NApOnEPyVWwEsuE2MldVVA==;5:05qMNshUYBE6SwWp4rT0h+bT7a1SoKv5597DSeNinDlJ9TswzZ//fbFSBBE42yRaNQsiPgvLvwZrhZnO+DUuJoAP/JErqsQo8n83R9h3qTwuYJ7+S2i7gDLaHQAt/GdLq+2MQNhpy6WXfMaFWuvDtl99S3ld+TWs8nEfBEOaEw0=;7:B2uLkqjtMK6/yaJ+l+EVfVGXkKDJNqNOSBDiUtsJOAOuxk4UI5zvfyde1kpaCjJ2DXcGgan4xZASs6BS8le8m0Fl2dmASI0XJrbgATR8MnBMK2ahpyhzJceUGJUiBv+UaVstcUEPFQQgSQZbS+GLYR1sAsBsk2Un/5TVD1d2OyLXRR4iFghNWQDO9/FR7XfmSLMC79NVanRF3qyuITp5fsAn5vf7EWb4EoxNzS+02YXbNdABCDDZB26OYzeD+LVJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 16:27:19.1300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1b76a0-d735-4e20-5bd6-08d627bac252
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4658
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.10.2018 15:23, Fabrice Gasnier wrote:
> This reverts commit 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00 ("pwm: Set
> class for exported channels in sysfs") as it causes regression with
> multiple pwm chip[1], when exporting a pwm channel (echo X > export):
> 
> - ABI (Documentation/ABI/testing/sysfs-class-pwm) states pwmX should be
>    created in /sys/class/pwm/pwmchipN/pwmX
> - Reverted patch causes new entry to be also created directly in
>    /sys/class/pwm/pwmX
> - 1st time, exporting pwmX will create an entry in /sys/class/pwm/pwmX
> - class attributes are added under pwmX folder, such as export, unexport
>    npwm, symlinks. This is wrong as it belongs to pwmchipN. It may cause
>    bad behavior and report wrong values.
> - when another export happens on another pwmchip, it can't be created
>    (e.g. -EEXIST). This is causing the issue with multiple pwmchip.
> 
> Example on stm32 (stm32429i-eval) platform:
> $ ls /sys/class/pwm
> pwmchip0 pwmchip4
> 
> $ cd /sys/class/pwm/pwmchip0/
> $ echo 0 > export
> $ ls /sys/class/pwm
> pwm0 pwmchip0 pwmchip4
> 
> $ cd /sys/class/pwm/pwmchip4/
> $ echo 0 > export
> sysfs: cannot create duplicate filename '/class/pwm/pwm0'
> ...Exception stack follows...
> 
> This is also seen on other platform [2]
> 
> [1] https://lkml.org/lkml/2018/9/25/713
> [2] https://lkml.org/lkml/2018/9/25/447
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Tested-by: Gottfried Haider <gottfried.haider@gmail.com>

Tested-by: Michal Vokáč <michal.vokac@ysoft.com>

> ---
>   drivers/pwm/sysfs.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> index 7c71cdb..4726d43 100644
> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c
> @@ -263,7 +263,6 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
>   	export->pwm = pwm;
>   	mutex_init(&export->lock);
>   
> -	export->child.class = parent->class;
>   	export->child.release = pwm_export_release;
>   	export->child.parent = parent;
>   	export->child.devt = MKDEV(0, 0);
> 

