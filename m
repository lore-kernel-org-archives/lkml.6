Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeDJEvr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 00:51:47 -0400
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:11912
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751427AbeDJEvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 00:51:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shyam-sundar.S-k@amd.com;
Subject: Re: [PATCH] mmc: sdhci-pci: Only do AMD tuning for HS200
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: satyajit.sahu@amd.com, ssundark@amd.com, craigb@chromium.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <20180406220806.150534-1-djkurtz@chromium.org>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Message-ID: <02cf09ac-2390-2d80-a77c-b79c21783664@amd.com>
Date: Tue, 10 Apr 2018 10:21:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180406220806.150534-1-djkurtz@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MAXPR0101CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::34) To BN6PR1201MB2499.namprd12.prod.outlook.com
 (2603:10b6:404:ad::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: decedffb-fe30-4354-e6e0-08d59e9ec187
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR1201MB2499;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB2499;3:EkmkNWJvxqHVLwI0x2zdovE7sLbXtyIsdbNkc7Oi9dT5GxAfHS9DKb+njuejW8mgTLq15oJHmsugtKKm0XK1FwadScIBCMhdTo+0K2v2+ebdHrZN7zAmNN2NygDOWm4eXIqRvZUGV7FU77sWaVsPk3qznXO0SGQoy4SI58uN+yaB3JG2VlGI1JXSAITpvyVU6CKhG1L9Dctvm90ucXW0Q7nt5vK8e0sim48wgvZPpckdKyMuokl+eVBI7cMsTDGp;25:AnJoTvYX4GoK2aChO1zLNwuBbf9ohFAssNzh5yxTC8/mhXBHQ3FFBijXax2Nld4g16Q5nkOCyLVgdF1j/n7B5A5M/L8bGel3hpXva2fR+cDnfMXdnZUguioIAKcN5SV61vGnvq2hEvGWB/wcABm9GDu+69R7s13r8srMaa6uxOFJO0qlmoxNerZJvtIW0L21MAbvtFwgqabZFsW/icCh22rDzaDBPZ5ilvYzZu3NTXT+yVK6KRgWuCs7JbYmKRBVXuddIIkhSVHnDK9lZ4RM24HSleTgfx+gkJYjEGQ7mwfZh8v4VTo0Lm66eSwU6PmLVWgrmHmS1NFmHWXBMnJFvg==;31:hTRf/ZE3H+y4teL/LZuoW8cJ5bNk/0YXV55v2ob/Iw9cYnitGYgeSwuDKu07LeDd+oSxlGQSq/Vl1R5IP9TfxJJFdO1wu1H9GJg3mLRrD+n0dtEtzvFnEoyB0vA6Nt4TYsbkmSCC2EgCaDkuu6REeoSd+EQHdM4Fz4N7ufD/Ddz9PedR2UDw42QTQ+YRlAXNpUrCIr6Lhzl5CJH9PhKZt0TgY4zWsOnTBJzivI2fxuQ=
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2499:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB2499;20:ZFpmApNtksgoxfsv2bS6yRmFCAX69X/jMrnxJW9oHjpsj9qdjy4nNIvN+Q9lMNQUQR/RVX/iMEWoK6CX0pQcs6SyMELp0PqXj2/bcp/ICASPI/vg4x8Eo8QRABBZl8TSLY/CXj8tXhAQNDd1NJaAAmZ9X8Rz+G3YFFmjJIGOZuGFkoPJoV0afVgM3tDvbcD5bVUWEpRBIVsbsD7SbVoKm7xzFYKJJJoNUzvh2AANhw6RTs0i2DVdUIEFrA+k+eHvakbIYtNtwjAb71B4A4cxQuW0Pm3H36IV4XftNAv1NvL6gYqeFrZmcE5v/qeqCRebUtzT/k/kJmX3Q1WRA5gwiMHK7a39I7fK4wSW6eN7GQbW+rZMD5gJu3Zi+SexDj3bFP4VKI9y+/lIYbV/0hjjVTT1ZYeL7VuMp5lhtAmMC6kFJRB3/uTroPug25qM/6n874l5IKf3O0POSAtF3l+/cE56gU3fZOa7ce5AFhiy4ok3T9iFW79i/m7Ht53CVBgl;4:v6/mYpPUO6+gRhxROiKabg6M5NFJAEMGXODPJ/U9OoQDjZouoJNF11XquVssMW/51bFuFSF+rMBWzanovL7BY6rQ+8UmP6vR9jbtpTh5AsDHBueVufL1KomtKk2LNPduO3raJhu7+pxaR/309AM4bNGn/xYph/yCU67GhIoCdTkqA5vWQpxk53nIXPOA8IjCDEzibusbhAILQoTY09ukJHzNJW5/nPZ4ZHQBxytLWYzWBUPAQsY/oiGljVzhupg1TZXTHSOkq66i8KjN3ci2mW/wo+IpQbBN2RZLR+LLfl+5I43Ztjr9cM3lQXFr1V9d
X-Microsoft-Antispam-PRVS: <BN6PR1201MB24999080D5C4EE305D86ED9F9ABE0@BN6PR1201MB2499.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR1201MB2499;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1201MB2499;
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(189003)(199004)(446003)(230700001)(53546011)(47776003)(31696002)(11346002)(386003)(66066001)(4326008)(65956001)(65806001)(478600001)(97736004)(106356001)(25786009)(3260700006)(68736007)(6486002)(6916009)(5660300001)(31686004)(65826007)(36756003)(186003)(6116002)(105586002)(52116002)(77096007)(26005)(23676004)(52146003)(2486003)(3846002)(6666003)(7736002)(50466002)(6246003)(8936002)(229853002)(16526019)(76176011)(8676002)(72206003)(81156014)(316002)(305945005)(81166006)(956004)(53936002)(2616005)(2906002)(476003)(486006)(54906003)(86362001)(58126008)(64126003)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1201MB2499;H:[10.136.129.16];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyMDFNQjI0OTk7MjM6V3o0NTlEQXdrZk9IU1BtWmpnS3BKMnhS?=
 =?utf-8?B?eUh4YkVBdkhFRGFHWDVFK25paVBVWTNUcXo1Qjh2RkxoWnVCMnZSUDNJd3hO?=
 =?utf-8?B?WXZRMnJFZ3VOMUZoalIxSW00Y2J0anVOdkJBekZHa3p4T2NIaWxlRGtCbkdx?=
 =?utf-8?B?Mk92eWJnQkd5V2hTK09zZmYxc2lPMVQzeGxWbEV1aTM5a3pReUE0NGpMTGgv?=
 =?utf-8?B?SXI1Y2lpdzNqUDUxNlRvTHlmbzNlemdOV2lmRHkrZjcvdWRBWXg4aHVNdm4x?=
 =?utf-8?B?OHY1bndHNVNVbUtuWDhNSlFwNVUwZHlWc2J3cE5CQlRWZjFvbDFyeVp1elBL?=
 =?utf-8?B?VzN5OUlJbVdwbE0zMmZZT3JYS0hpdzFDYlUvaWJ6UGs0OExmcDVCQWpoemxt?=
 =?utf-8?B?SDJuOWVuV3QzOVBSYS96MTBqSkp3Qy96VW1EOGlkTm1RbitMWENlNWUrMTAr?=
 =?utf-8?B?QnpHNHNGT3lNVVR2VkJZdW4xTHh2ZC9RU0dpOXB5L2tmZ2NpdFg2OFRxYjQ4?=
 =?utf-8?B?T3UxL3ozeVpDai9ON0hPaGtLd0xvQ0tUSzR6WjNIa1gxcFVBL2N4Wm9XbENj?=
 =?utf-8?B?L1pOWGpLaFgzenNyaEV4U0pmYWlxTVRqQnZNYVpGOU5mQlBEWEdhcFo5VGtR?=
 =?utf-8?B?Y3VJejFhRTBDUzhVZXdvUW9oeXFHeWJEdDFVRXJqZG1TSFBqdXhxb1VBdGRK?=
 =?utf-8?B?dklwUDM2T2FCaDk4dmJ4blhJZHhUMDRHdlkzOXU3b2tOY0JOT0ZMZzZ6YWZL?=
 =?utf-8?B?MlVkdTdES2N6Ymd4R0RRWGZnd3VzVTJYZEFEcHF5VWpETlkyRm91RjZaMXNS?=
 =?utf-8?B?MXUzYk5hbDV1UkVtN0Zrc20ydFNJd0NJZkllSzYwK3pFMTlEU0tKZmVNNW5y?=
 =?utf-8?B?cmdaWnJ6QjFaVFhDMi9UeHoybVAvSEZlTDdSVDdqcmt5anlLdlR6NVJWWUVt?=
 =?utf-8?B?Ty9xNGVyS1h2c24ybU1ZT1JFTjYySHJOQUl2RVJkam1UTFdXUjhrSm9hVUFa?=
 =?utf-8?B?T01hSTM3cERwTXhNSi9HT2J1bk93UDlpc3BVd2xHcEVyNXI0azZ2aUNteG1H?=
 =?utf-8?B?aHo5VG1qdHRQY05QVGhUcG1QdHVIL1RDL216bExXYzd2OFQrNjJuMXprUVpE?=
 =?utf-8?B?WXpFaGQ5VzBkQnErK2wwWEFxdWV1T1ZEYzV1NlRaU1FRdVE1THAyRVd3ajd3?=
 =?utf-8?B?WDh3NitKV29XUzFONEpVMFpieDNrdzZPVU9UUVBPYXQzS2VQMEYzTkZpSkRV?=
 =?utf-8?B?WERxejJnb0RLT2ZaWWxxdEJwSVkzWE5sLzhxQm1ITXYrWlFGQjhJNEN5c2dj?=
 =?utf-8?B?MytJYzVPektSVGNiM0NGS1VTSzBRMHlMbGFoQTB2NDlwamQ4OTFUTFZYRU5r?=
 =?utf-8?B?SFFQQWpxd3kzaWxCZDFoZ3FrampSQ1FlMFhmb3RQN245YWs3WG1sNDFwOFA2?=
 =?utf-8?B?MzM4VUJtZ1pNeGxtd29Fd2xnV1JHZ09sYnpWbUhWQU10QkQvMCswcWVmbmZh?=
 =?utf-8?B?dVpsejJzUGZiS210aUE3RjZKVDlIaEdDYW93dTRlTWh1bEIvQzJ1RDZhdFE3?=
 =?utf-8?B?YUMwcUJXZlhCNXV0allSdTV4US81YXkwMHljNjZOMStnTDRsTjFWLzQyYXZk?=
 =?utf-8?B?bVR1aGNGRFQ4NXN6djVrclVhQmFpUU5IOXlVanBETE5XN0JBNlFqcEcxOUhC?=
 =?utf-8?B?N0E1QkpGSHRSeEtsSC95cmEyWXU2U05wTllPeFlUYUhMRk1nZWtHUjBFbTZQ?=
 =?utf-8?B?dEZqYWhNQlFhT1pvclFPL0diNGQ3c2JrTWVKaHJOT3A4c1UwU25oazdQV05I?=
 =?utf-8?B?Tkxxb0RlSGQxS1MzeTdJQkFtb2l0N2UrSG0zZzZEQkZQNzlYaVFaeUhsOTZE?=
 =?utf-8?B?VGlLdWdXUG5QTDU1amNFV3BmTXFtcHpaN0trYkx3S1NUTXlmeFRVeldzbGoy?=
 =?utf-8?B?RHhsOXdUMWREYXhMWjJiSllmUlJJYTB4cWplVHN5SExlMmZGMi81N2pTOW5k?=
 =?utf-8?B?Z1dERHI0aWVGbXFEcWJDWlNuYTJuOUJrTXBNQk93PT0=?=
X-Microsoft-Antispam-Message-Info: ERstK9xjCkrsW0uYTcrbxG0R860nMy6s7dApnh1xu0837IHue3Tb1LpZgRvmDSLSNy9Du5uwo6RwlFzYouUSjhvcf4gth80T1S+5G6jRcP1X5VBsRO0vWYdIipFDwIJ9dQSyVKftC14POUtqFHeFaQZw2zAHy7HzWFTAYWpbifP+1KQs/byG3CnZzf0KhFFR
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB2499;6:1c2KzqN+XOmEJVTWIaNJJAI1VpMr0KMHrJGChjksylVy1+SEtDWBSs86wfSfSKLKfA4aITvggnuBLihKSET63RRTiMrT0Wiq9Avays3Sf5k/XS587UPegtoMGoQfXzOpWmk9xN0bMoZLMbp1r/wbBJnD74C5FCbKIZdNjU6snGCbXdjrqdtqKGsOW8tO0e6n0fXIpb0p0SCCGm9iehkOO1Q97jgiAJNhaaafXLELWGt5MICzdTtfdewzBjfuW7mJv8+TDFvNGh5e15u7wmjrgiNVI0Q/XpHq+AgUNfnHGnCCO427fSZyM28a6zC3qPyD4k+4z1EjqjxOVVCu5QBUPlUQp3DENWtPM0zj8z9WHBR5y6Wh9lsN0wYzhF1CB2i3TxzqS+OJqbVEi0lnhJ3NXSZFZWBttaqvTUkRLJmjNfkdXtYCFx1B67CKpgzrx1JKUNWrjvmScRBouYC47038nQ==;5:QO3l+oPvLgecmcYVV4PzSFYhiwpCigre1xgkqBD+Ag/agXg8fKJ9lKO5IwSldjjAm1Ibj+Y0V3kAhpIdpyw7eSXgvyJWZ1AcRXUyO2NS74JWEwp6Y66GcGwi4tK5F0RDhur0D12jZLAEA+Jo6fvjQSEoQCGwCmfJyBBMUC4ISU0=;24:18cDc/DiD9P0lF1n8SBIzsBiz8ovSfXZLQom7HSlg0z7Zf41XAA/UFhZfcVPYWsQk06Uh0SIB4HV+h14xUv8/QefufIbORiXrlSgao0M2TQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB2499;7:vVT5f1ISK9D+5xhtkPTT1Iir9Rhh/rUdlyBMVTz9C9GoShAZeCPujoE8NoLvxMjtLCgEfcbrOLpNSOacgO5G9dXcjT7K4ba/VZH0kXHVPcl86o2tH4QV3w3HLRWTETcdfeDUVGPmb1Bp2nTr0Qa1rndpp3rYmAadJLRS8EyPu4pcvLbxY5utxnfQcmFSjfroce1kzcfcyPpmqlaD5Qc5JDjYZ/lmVm5bEkuzRRRqslmkx5+chHOYljkpcr9fia4q;20:0wYyo0jtl+DXbc0AQ2vzzYoA4UxMILIazvmobB7o7a8Id38qlZ0EC9x5O8tvE73IesD3j9hwpCY3Afh+yNiakANUucFQMM7eD9xnjbeI6vXSZXpveZsq5xssIDlNUbyy3jeb/QdKzm/iahpBoQRsCT6CDfmtesxImvej7xtMWmwrUBXduCbJgDe6qh/Yj1J3zNLShoX4gdcbceEIbWdZ1ESfdUt+xkX9/sesof9Egk70KBU9o+B2WdINSJ9XFcLR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 04:51:39.3551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: decedffb-fe30-4354-e6e0-08d59e9ec187
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2499
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/2018 3:37 AM, Daniel Kurtz wrote:
> Commit c31165d7400b ("mmc: sdhci-pci: Add support for HS200 tuning mode
> on AMD, eMMC-4.5.1") added a HS200 tuning method for use with AMD SDHCI
> controllers.  As described in the commit subject, this tuning is specific
> for HS200.  However, as implemented, this method is used for all host
> timings, because platform_execute_tuning, if it exists, is called
> unconditionally by sdhci_execute_tuning().  This breaks tuning when using
> the AMD controller with, for example, a DDR50 SD card.
>
> Instead, we can implement an amd execute_tuning wrapper callback, and
> then conditionally do the HS200 specific tuning for HS200, and otherwise
> call back to the standard sdhci_execute_tuning().
>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Looks good.

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
