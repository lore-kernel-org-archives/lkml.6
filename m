Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B8AECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B2A21536
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YKdxTZZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B2A21536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbeIUFX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:23:58 -0400
Received: from mail-bn3nam01on0040.outbound.protection.outlook.com ([104.47.33.40]:28544
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbeIUFX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQh3rDIIbZlAREkmf3xMFjAlwi0j9TTBaa1ASPQnO3A=;
 b=YKdxTZZtyXmIC/t5j8lPAJ0EA4Wzr0TwrXSJe2YjoRvW5UWNzSEGOoVUPsW2CBu3Q1seshtqlk7Nz1N7wMzbdABP0QhrJLVj9fHp1FGoJaBVOulkEfKBQm6bMpjNRI8MvLYEUsTd9yRXZeBMt9Tb/bKXIZfdS3oWNWrZCNfxL0Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from [10.224.54.236] (165.204.55.251) by
 DM2PR12MB0187.namprd12.prod.outlook.com (2a01:111:e400:50ce::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Thu, 20 Sep
 2018 23:35:50 +0000
Subject: Re: [PATCH 1/6] drm/dp_mst: Introduce
 drm_dp_mst_connector_atomic_check()
To:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Sean Paul <sean@poorly.run>
References: <20180918230637.20700-1-lyude@redhat.com>
 <20180918230637.20700-2-lyude@redhat.com>
From:   Harry Wentland <harry.wentland@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=harry.wentland@amd.com; prefer-encrypt=mutual; keydata=
 xsBNBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAHNJ0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPsLAdwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2zsBNBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAHCwF8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <fb7f2556-0578-c119-a81d-b2e717a0ef89@amd.com>
Date:   Thu, 20 Sep 2018 19:35:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918230637.20700-2-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQBPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::26) To DM2PR12MB0187.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c35e739-5e5f-4636-4369-08d61f51cd66
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0187;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0187;3:FrufqP1RNqRFRCmsvMdzIOzHJu+crnXYrbhjO7KQyEvikRa1+vWh9QJP4n2Fhslue6+mTzw/VAVI7qJjSCGSKua4R2KC82PRqYgXHqw7ieIExP7W84yJZl9u3KHhczzU/667z84GN+c2+Gnt1BZBKQ/LK9rxXC+ESGB7tAQ/hkqke7qfT9G7pndlpH+FC1/Hs/W5/JjidofXs/Audn/0sO9AH5RLKU0R1wC5moFG2AZ4NkxNbzsrevjxI2rd+Aeh;25:VXFFYvfxBC08KYk2tut6elHtsKlDQxpwM4f7eYSdf9FW5vuqeRjUTBM9yLN8qGRTKKDikAMOZwtYlFKDFiELXHYYLyGsGojpSIWQR7kfXWWph1hlp1S1gBeT0//lf16cVPSjT7fcuwTcGRxuRSQlLm2J++hr2t8k1fZqCTrm8Wtd0ZKvGxCutNF2PV/eKGXmVUkuYIsF2/UTaoRFdA+YQ+snFTnHjiIBGQoO0YVmHjzia/SUcvCkDhBS/iOsyuXPldcaGA9pzGHkAGgNA+pE7FAMz0D/rbOEQ1qDNhw4GObc5PbIEweH+mQDo5ZqU3Gr1+HjrCZcqOc37sEzJiE63A==;31:vVGT87pxWV1MNuPABN8HJ47NYeMniMVtucKLfSVTutZupUXkXsxaeNKI2Gf4GVzPLVeH3Wd09aYDcyFWh9B9B6y3jLujm6rdjOxQdAev5VSN4zAJ1cQcpqbo7wbo4z0NQdPkP8qnLiF6wwZcYTcellw476Ozd+q5v9LVJxOoj4nZaF3GNJ2gd88bkz9Nu5ixjetkxUdWwwlE2fBC7XGh93jgCkuwJmxDuKOOqZLl1mI=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0187:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0187;20:3I1CSac+9Yzo9k3xUnYksGajSnyMXqXMXNAmCnBDJrOVD/ZpsGCaDEl0lI5DB0T2mhXpjoEq0XXyC2H3XTyBMuhkeF96mWqYeaxtkZzU0paRyR/986OvUnxLvaiYf9CiqtuoMsWr2DEM+2uaTamggkAgJZ3c3Z9+ivRpAK0D4Ipb1gt7JEzER/CJm+dgVLyHmbnboxgHrRlAaHWChdM+CyNbfiHlzgRKDt5DPheds+TPI9KLz3HP8gVEdY1+hmYnxWZ2a7jZ04fknkqsuANHT0MRLjXonbNOCpLc3WPV/YNBQllAy/Nhcju01q35dSIvfW5KzMGRPpjd6QwdDKtg74wP0tUSorw+EPzdq8P7Z9O0/nYBTNVQDMiR2LqB/8QJEaeHlUDsj/OlKvxCbMcXGJZpVu2mlLOYwgz+wXErU+krDOMckyoyZCTl18zrIDbb0pkba8Y1mQ3xi2jgB3EeO8KqYiTkE4yWaVUqSDfX5iuTJjhPLtbVurTDNfzRTV3l;4:ij0eEnZasxsyDRptDSVsWgSvitL1CcH1MNU4/bkXXHT9kuiW+f7xUWQ3QWWinvPQd/I/b3ekn4DzHmkgZU9D0jd6iIKHoTGed4Y2xWiJc115GEdCCIf2vbxVcarf7/UbJKW5eSz1j+hw15+mbOnjW9FAUqvk8N1Rix59ULDyKFrlnIpVNnr0GzvGl8DeGnE7ixwGnimifjXcRr2JBtfwLjrab18nHUOyycY60IPDIdTGAHsB7GxP/nKJPmy1iw3NOCFDzUczdAvY7jG8PrnPqbfH5MyVpHVlMYjaGmCdYgPKX/pPNcxyYDFDtqWY9RL1aPcu5MHfjvahpDXVIodqTg==
X-Microsoft-Antispam-PRVS: <DM2PR12MB018794DBE9BD3F3204C8A9AB8C130@DM2PR12MB0187.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:DM2PR12MB0187;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0187;
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39860400002)(396003)(346002)(376002)(136003)(199004)(189003)(64126003)(65826007)(53546011)(72206003)(105586002)(31686004)(230700001)(77096007)(386003)(7736002)(68736007)(8936002)(956004)(5660300001)(2616005)(16526019)(97736004)(3846002)(6116002)(76176011)(52146003)(26005)(52116002)(23676004)(446003)(2486003)(186003)(11346002)(476003)(486006)(316002)(81156014)(36756003)(16576012)(58126008)(6666003)(54906003)(4326008)(25786009)(50466002)(6246003)(2906002)(66066001)(65956001)(47776003)(44832011)(14444005)(86362001)(31696002)(305945005)(53936002)(229853002)(6486002)(106356001)(8676002)(478600001)(81166006)(65806001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0187;H:[10.224.54.236];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTg3OzIzOnFLUVR5OWZCRlJsbjUrb0xEcUdVMlpHb2F0?=
 =?utf-8?B?NitobVhoZkVBQnMrbW1SMDBnSmNDSWVSemR2ZUQ1QmZOR1FJTzFUSWhCKytW?=
 =?utf-8?B?UnRYNjZNQ3RzRXhkTjNrd1R5cXdOSHRrWFRLbVZnUTQvdk9objFvVlFwZlFJ?=
 =?utf-8?B?NHdSQlNvWDYwS29LS3I2Z3V5Z0Vtd09iNm5LSTVGNzdxQkJWRHhHNm1IM21H?=
 =?utf-8?B?RXJxSXlJdExMVVVCYXJUY3JDMmJocnZhRERWVnVSd2tWQ0JsMnZSU0xUWlFN?=
 =?utf-8?B?NU5QYlowYVpOMmErRDI1TUNzdTBEcjNGcnJLUk92Z2JqTFRiZ2E4ZmtIVTU2?=
 =?utf-8?B?aU4rRldSMlllaDU5ZmhvdjJtanJQTGJLWGJEdGhaMWVrWDdud3RqV0x3OThI?=
 =?utf-8?B?SFlWblpxdHNHRWRLYjkrdWsxTmJqb2haN1NoSGd0OXI0eGhIMis4YjdoSk5N?=
 =?utf-8?B?SU1nVkY1VmdMOURyTlhybWtqa2MxSDVaV284MzA0RlBTR1RWZGR3a1lKaG5a?=
 =?utf-8?B?eGovVVNnQzBxSnRIY1JjQ0x5L29KZ2ZHUlA5TGtHUkVOaWtTby9teHFhNXl0?=
 =?utf-8?B?NlVrMkhXcWNFUTU0NUtrZko4UDM0RHVjSzJ2YkNqQm81RWtaRGVnSVdFdmpk?=
 =?utf-8?B?VVhDeEFkQ3Fwa3lFKzF3RTVndzF0SlBuUUFYZ0pmMUVEN0VySkNoNDNCRXJS?=
 =?utf-8?B?ZUc5T1BlQTV3aHJNUE1SQ2xKWEhpUGYyY1cxUVpGejNLMGx2ZE4rSDFLN0Zo?=
 =?utf-8?B?WStGdytwK2xRVkR2aTFZUm9CZXFtdHNldFJzVktJMzd4cEVSUExlbHlDWCt2?=
 =?utf-8?B?STR0eWZVbThsWEJZLzFaRlBRT1daOGhMS3JaK0ErcXlCTFZ6U3dpYS9RZ1Zt?=
 =?utf-8?B?SFBBbkpsVGVPck4ycllzdDNKQzdpUEFodGY3S0VncjNLMjVPLyt2MEovOVJB?=
 =?utf-8?B?U1dlYzJiOFV4ODJIS0llS2lzdXN2M2RHV3FIaVBpaVBQRVVsK1BWbFdyWHFB?=
 =?utf-8?B?OXVIUmJyWFA5ZE5sdkVCNU81cW85RFNmUEVIMEcvMUJxczhMdk1RL0lIVDFR?=
 =?utf-8?B?YXd4VUl2b1ZwTzJkR2JnMjNWTnpib1E2VE5WalZiWVlUN3AxYStCQVJTanBU?=
 =?utf-8?B?bUFqaS96eWVydmN3ckF5aW9XZlVObHlFdW9rR3pBYnREN1B3QjJXaUdqV2d5?=
 =?utf-8?B?d05CdVpVOTgwRlRNbGlnT2I3SXp5aVNQWVRhclRueWxrVzNzdGFUOVRzL05v?=
 =?utf-8?B?R1lHWG90amRkQTNVTlhldTJKOWk4c0RXQmpUMmZuVHJqM3BJNWk1Vno2eG11?=
 =?utf-8?B?MWJLZmZYMWFrN3QwaDZ2TFo2Qjd6UFdTNUp6Q1NhSER2UjFMNlk1QktOckQ5?=
 =?utf-8?B?aVB3TmJoVlExNlJVT0Q0V2RMcHBWeVRIQlhqK2NFQVEydDVScm1DWHhsYmh6?=
 =?utf-8?B?cWV5cVZKQkFSTStxZTFwTlptY0V3eXNtY3hYeGZYMUV6OHJoWTBzRkRKNmlm?=
 =?utf-8?B?MFdybHU2OUZmRzZ5YW44RnBuOUUyL21aNWZYeWFXbm9NbUxWUFpsc3VVcTJ2?=
 =?utf-8?B?TDNsWVNXSnQyR3dhNWRTWEVhQnAvY0Z0SnNpQTJJZ0VYU3BYZEx6NUdra3hs?=
 =?utf-8?B?Rll0ajROcnIxVTJTNlNRVzVrYnl4RU15bmhEUmFRbU9DbmwrbDQzRDlwN1Bn?=
 =?utf-8?B?bmVNWkd3Z2NqSWhBUTdSUjE0OE14TXo2clF1TnBjSWxncStTb1ZubXFWSVg5?=
 =?utf-8?B?UkVYMFVtNlhkQ2lLTjFzVWpWNlFmcS8xZERLMm5NeDUzcytJS1J2THVoenlz?=
 =?utf-8?B?Y3A0MFcydkx4SkR1ZEV6d0lHRzB6TENXd3E1NUZSZmo4ckdMUXprVjJ3VzVU?=
 =?utf-8?B?MnpQcHJyWDYvZlpUSFdDbzNtWGZNUHBUd3g1WVdWZmRsQmwyOG5uVEZta3VR?=
 =?utf-8?B?dy9ab1FaWitEbzRlSHZVbDFlcWx6V010cTZUaWJmL1o0Z2Y3UlgvOUdnait1?=
 =?utf-8?Q?wNb0Qd?=
X-Microsoft-Antispam-Message-Info: VoCRBJHPdYMwrww6XvxlKB899U/eic1AbmZpml7+XqaJMzZM5oDQ3rCAoRxP14+FYK0O4zsjlG/lEp+oksIPYYg0hJ7MvraTWB340jEOajM/qOiY8WtOfUnwd0bbYiPxNr+xUvRJJO5o0Gwum/oruDX93eF0FOvTWxgSq64g97n000fnRkgd7go7d1hb//mshWtcHbiLmz20o3sRkqi/t1tlXCAnsOM2pjKHY49SPIy9svJvYAu4PprU7H9HJGftaFMhfLb8genqEGRZMIR/oAlw24gImPlqFn1sYmsxfW6pZDXzT6/dEEKRabnmRB9SC8kXk+Zk77qqx/02WhrnXqdMsYjjZuQmCIwhMXMsqD8=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0187;6:Dbzeb5HbP86utVUnNElDpVOB8b3VL424DQAWikxacs8BpMeB7j8S9185H6CJeRaAlBecId0+GciTG4Ztc4fHGzLjNjRTlSeAezDYRh4xbog+vDxwBxq0J36PqTXTyXdZxEEZSE4Q8OjJzRS2w2jLjIqm0x4hSh7dhpc1zcwzl3kArgIB7LkAQWUTninq9ZM01ROLDc3Ps3Vl+8pkCJITzPeAWH8NIeAvZmZdIYVKRrcb7xf4GSQKh0Hl11UTo1VcJEMwyTEoCC2gtI/cUOJq8GcHHUhoMIwPCPZYWTJKjOSfvAVNEkWyr9tYvqVTse6yAEvqkdSQKJFebs5vVXGiy22ihzj9krc6QlDBXoJcqpKYlkrUoAZEgjzdGD1Ki+rd0ZiKUBYXSocMQAUvsdZxQQOovx7I18W+URFv15hC+/w0oslUw4uSoJDo1XzRlk+KANvp7Igh35atyOVqxAV3jQ==;5:faq9/WmKcrT6RQyqlsoXUYL/51t7FeOF89Upyu0Nppumt+g084oCNIqTxKH3hieHckOiQq5cF6TBZEpynQJ5Bfi4sij/AFguvpUzpHw9q176s/0x1cgxfaT2YkZ3JTrifaPvgtckAFzJ6TP4cfpdfcSf41CAKobfg+bMw/xb7nA=;7:FyYEkKlV3Ca3FRXyhWbemYX/iSIRjWZNMMosjn8xy3ES6fVXG5s2EjIKu6wWmDiE6+VWmKoFtpR/hwcPx9UFn86LQAxYZKIPi86+tMZ4NiUaLu2BCGBACSyvmM2e8c/xPTmL8eWMbPoaNs7f9tZKnGxikKZPyl9vAy3LiK7mORy8uU3EChdSLGbcPvk3+gvSF8RNV2bFcDaSTfg4PUlbJJFJe7oStcC5+aLkL98UciCIULeYjK5tdFzdOyb23wlt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0187;20:gE/6/IQvqcqr1/5US6v6GceTe1+lnFqGf5MCiffK5cpLk9p2ycU4t2o6mftFVmJlXEpzjD4uala0m0qDDgasoL9wULxOK15MRsQgF23fqp9e0r9jRK3gYyA34mEVjnpKEMgVdCmRjyFkRxX05lRnryLCmqu2XVu9GJO5GX/JfDQivZbo1EZIO8BrdDLAek4/+lZXl3Swz3S2PS/Z+y3Q9UhV8ufpbEPDWyvjW0+v6NnYHrce73akQSLDOITAPf2k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 23:35:50.9909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c35e739-5e5f-4636-4369-08d61f51cd66
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-18 07:06 PM, Lyude Paul wrote:
> Currently the way that we prevent userspace from performing new modesets
> on MST connectors that have just been destroyed is rather broken.
> There's nothing in the actual DRM DP MST topology helpers that checks
> whether or not a connector still exists, instead each DRM driver does
> this on it's own, usually by returning NULL from the best_encoder
> callback which in turn, causes the atomic commit to fail.
> 
> However, this is wrong in a rather subtle way. If ->best_encoder()
> returns NULL, this makes ALL modesets involving the connector fail. This
> includes modesets from userspace that would shut off the CRTCs being
> used by the connector. Since this results in blocking any changes to a
> connector's DPMS prop, it has the sideaffect of preventing legacy
> modesetting users from ever disabling a CRTC that was previously enabled
> for use in an MST topology. An example of this, where X tries to
> change the DPMS property of an MST connector that was just detached from
> the system:
> 
> [ 2908.320131] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] [CONNECTOR:82:DP-6]
> [ 2908.320148] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] [CONNECTOR:82:DP-6] status updated from connected to disconnected
> [ 2908.320166] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] [CONNECTOR:82:DP-6] disconnected
> [ 2908.320193] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID: 111 (1)
> [ 2908.320230] [drm:drm_sysfs_hotplug_event [drm]] generating hotplug event
> ...
> [ 2908.638539] [drm:drm_ioctl [drm]] pid=12928, dev=0xe201, auth=1, DRM_IOCTL_MODE_SETPROPERTY
> [ 2908.638546] [drm:drm_atomic_state_init [drm]] Allocated atomic state 000000007155ba49
> [ 2908.638553] [drm:drm_mode_object_get [drm]] OBJ ID: 114 (1)
> [ 2908.638560] [drm:drm_mode_object_get [drm]] OBJ ID: 108 (1)
> [ 2908.638568] [drm:drm_atomic_get_crtc_state [drm]] Added [CRTC:41:head-0] 0000000097a6396e state to 000000007155ba49
> [ 2908.638575] [drm:drm_atomic_add_affected_connectors [drm]] Adding all current connectors for [CRTC:41:head-0] to 000000007155ba49
> [ 2908.638582] [drm:drm_mode_object_get [drm]] OBJ ID: 82 (3)
> [ 2908.638589] [drm:drm_mode_object_get [drm]] OBJ ID: 82 (4)
> [ 2908.638596] [drm:drm_atomic_get_connector_state [drm]] Added [CONNECTOR:82:DP-6] 0000000087427144 state to 000000007155ba49
> [ 2908.638603] [drm:drm_atomic_check_only [drm]] checking 000000007155ba49
> [ 2908.638609] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]] [CRTC:41:head-0] active changed
> [ 2908.638613] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]] Updating routing for [CONNECTOR:82:DP-6]
> [ 2908.638616] [drm:drm_atomic_helper_check_modeset [drm_kms_helper]] No suitable encoder found for [CONNECTOR:82:DP-6]
> [ 2908.638623] [drm:drm_atomic_check_only [drm]] atomic driver check for 000000007155ba49 failed: -22
> [ 2908.638630] [drm:drm_atomic_state_default_clear [drm]] Clearing atomic state 000000007155ba49
> [ 2908.638637] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID: 82 (4)
> [ 2908.638643] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID: 82 (3)
> [ 2908.638650] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID: 114 (2)
> [ 2908.638656] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID: 108 (2)
> [ 2908.638663] [drm:__drm_atomic_state_free [drm]] Freeing atomic state 000000007155ba49
> [ 2908.638669] [drm:drm_mode_object_put.part.2 [drm]] OBJ ID: 82 (2)
> [ 2908.638676] [drm:drm_ioctl [drm]] pid=12928, ret = -22
> 
> While this doesn't usually result in any errors that would be obvious to
> the user, it does result in us leaving display resources on. This in
> turn leads to unwanted sideaffects like inactive GPUs being left on
> (usually from the resulting leaked runtime PM ref).
> 
> So, provide an easier way of doing this that doesn't require breaking
> ->best_encoder(): add a common drm_dp_mst_connector_atomic_check()
> function that DRM drivers can call in order to have CRTC enabling
> commits fail automatically if the MST port driving the connector no
> longer exists. We'll also be able to expand upon this later as well once
> we add MST fallback retraining support.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org

This does seem like a saner way to handle the case when the MST connector is gone. As this doesn't currently seem to affect amdgpu directly and I therefore might miss something I'll leave the RB to someone else, but you have my
Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 76 +++++++++++++++++++++++++++
>  include/drm/drm_dp_mst_helper.h       |  3 ++
>  2 files changed, 79 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 7780567aa669..0162d4bf2549 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3129,6 +3129,82 @@ static const struct drm_private_state_funcs mst_state_funcs = {
>  	.atomic_destroy_state = drm_dp_mst_destroy_state,
>  };
>  
> +static bool
> +drm_dp_mst_connector_still_exists(struct drm_connector *connector,
> +				  struct drm_dp_mst_topology_mgr *mgr,
> +				  struct drm_dp_mst_branch *mstb)
> +{
> +	struct drm_dp_mst_port *port;
> +	bool exists = false;
> +
> +	mstb = drm_dp_get_validated_mstb_ref(mgr, mstb);
> +	if (!mstb)
> +		return false;
> +
> +	list_for_each_entry(port, &mstb->ports, next) {
> +		port = drm_dp_get_validated_port_ref(mgr, port);
> +		if (!port)
> +			continue;
> +
> +		exists = (port->connector == connector ||
> +			  (port->mstb &&
> +			   drm_dp_mst_connector_still_exists(connector, mgr,
> +							     port->mstb)));
> +
> +		drm_dp_put_port(port);
> +		if (exists)
> +			break;
> +	}
> +
> +	drm_dp_put_mst_branch_device(mstb);
> +	return exists;
> +}
> +
> +/**
> + * drm_dp_mst_connector_atomic_check - Helper for validating a new atomic
> + *                                     state on an MST connector
> + * @connector: drm connector
> + * @connector_state: the new atomic state of @connector
> + * @mgr: the MST topology mgr for @connector
> + *
> + * This function performs various atomic checks that apply to all drivers
> + * using the DRM DP MST helpers. This should be called by all drivers at the
> + * start of the atomic_check function for their MST connectors.
> + *
> + * Return 0 for success, or negative error code on failure.
> + */
> +int
> +drm_dp_mst_connector_atomic_check(struct drm_connector *connector,
> +				  struct drm_connector_state *connector_state,
> +				  struct drm_dp_mst_topology_mgr *mgr)
> +{
> +	struct drm_atomic_state *state = connector_state->state;
> +	struct drm_crtc *crtc = connector_state->crtc;
> +	struct drm_crtc_state *new_crtc_state;
> +
> +	if (!crtc)
> +		return 0;
> +
> +	new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> +	if (!new_crtc_state)
> +		return 0;
> +
> +	if (!drm_atomic_crtc_needs_modeset(new_crtc_state) ||
> +	    !new_crtc_state->active)
> +		return 0;
> +
> +	/* Make sure that the port for this MST connector still exists */
> +	if (!drm_dp_mst_connector_still_exists(connector, mgr,
> +					       mgr->mst_primary)) {
> +		DRM_DEBUG_ATOMIC("[CONNECTOR:%d:%s] has disappeared from the MST topology\n",
> +				 connector->base.id, connector->name);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_dp_mst_connector_atomic_check);
> +
>  /**
>   * drm_atomic_get_mst_topology_state: get MST topology state
>   *
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index 7f78d26a0766..8e33c2c85d1e 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -625,6 +625,9 @@ void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr);
>  int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr);
>  struct drm_dp_mst_topology_state *drm_atomic_get_mst_topology_state(struct drm_atomic_state *state,
>  								    struct drm_dp_mst_topology_mgr *mgr);
> +int drm_dp_mst_connector_atomic_check(struct drm_connector *connector,
> +				      struct drm_connector_state *connector_state,
> +				      struct drm_dp_mst_topology_mgr *mgr);
>  int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
>  				  struct drm_dp_mst_topology_mgr *mgr,
>  				  struct drm_dp_mst_port *port, int pbn);
> 
