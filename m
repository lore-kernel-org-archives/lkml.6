Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeDFA26 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 20:28:58 -0400
Received: from mail-dm3nam03on0127.outbound.protection.outlook.com ([104.47.41.127]:14716
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751179AbeDFA2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 20:28:54 -0400
Authentication-Results: spf=pass (sender IP is 117.103.190.42)
 smtp.mailfrom=sony.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=sony.com;
From: <Yasunari.Takiguchi@sony.com>
To: <mchehab@s-opensource.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <tbird20d@gmail.com>,
        <frowand.list@gmail.com>, <Masayuki.Yamamoto@sony.com>,
        <Hideki.Nozawa@sony.com>, <Kota.Yonezawa@sony.com>,
        <Toshihiko.Matsumoto@sony.com>, <Satoshi.C.Watanabe@sony.com>,
        <Yasunari.Takiguchi@sony.com>
Subject: RE: [PATCH v5 02/12] [media] cxd2880-spi: Add support for CXD2880
 SPI interface
Thread-Topic: [PATCH v5 02/12] [media] cxd2880-spi: Add support for CXD2880
 SPI interface
Thread-Index: AQHTkDg3Ow2lTpwQtUeAT9NJCo3KraPE2f+AgC5+sWA=
Date: Fri, 6 Apr 2018 00:28:46 +0000
Message-ID: <02699364973B424C83A42A84B04FDA8548B8E7@JPYOKXMS113.jp.sony.com>
References: <20180118084016.20689-1-Yasunari.Takiguchi@sony.com>
        <20180118084610.20967-1-Yasunari.Takiguchi@sony.com>
 <20180307071529.66e33f54@vento.lan>
In-Reply-To: <20180307071529.66e33f54@vento.lan>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:cf8:3ffe:0:200:5efe:43.1.76.63]
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.42;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39860400002)(39380400002)(2980300002)(438002)(189003)(199004)(2920100001)(102836004)(86362001)(26005)(77096007)(72206003)(7736002)(7636002)(305945005)(246002)(478600001)(446003)(356003)(106466001)(11346002)(2351001)(8936002)(7696005)(336012)(76176011)(54906003)(16586007)(316002)(426003)(106002)(2900100001)(39060400002)(8676002)(6246003)(2906002)(107886003)(6916009)(186003)(23736002)(55846006)(5660300001)(47776003)(4326008)(55016002)(86152003)(33656002)(2876002)(486006)(120846001)(229853002)(476003)(126002)(6116002)(50466002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1301MB2023;H:jp.sony.com;FPR:;SPF:Pass;LANG:en;PTR:jpyokxeg102.jp.sony.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT033;1:bOxO3SBcm0J6AgbPwh0fewVlxOsNdbOFR9igbsfmPiE+17+tu1PhS5xodauKjd4EXKl4vdSOjh0mJi0d/J/pDGGZXILdOvUo7q8OfPW/vaVh98FbEyjoiuv0i5ECG96i
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2e0e13f-bdc9-4004-786b-08d59b555fcb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:CY4PR1301MB2023;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1301MB2023;3:LztuBBtRHZPxwQPRoyEGOP9H+ZMk7g3RK+NTMWev6sgaHwMQszxu8Cp5sCYOXZoZ4R7I4zECxOqi3E2+20GEAc0tfrnirxj+JTonUGUyi+VWw9KBsjq0kdfy9PssnZd3eF+JD0/fRTmLWjRpyt5hifEaxWhf4AQizHfDo4FU3YdE+N+eSDnb3nE1//kR77RIgUGzPoQgQQ+Zqpetuwv6hn/S+5K+urN+N/vIZA1AaK60ifx08c6/H8Vsla+66iCAL+4akMhnFi7LEnHUqRFgyPNLfZstKuMFS0DLNL1FtpCmwNrqYy0cnQs1RnkhaJf5D6ttM2K/2R5mJgeh5UUyFzmKwR2vxBpsHSyI/lKPMHg=;25:6l5Eyqfrz4hNMRHrZm5oxZOyZcWA69Ue9ATGhamR3nvOeIIoxkDhNVSoK5yv4zb6WXBr1aEs7fk4rkSQSs/iIHto5VJnjvawmmmRSgOUigGupw3lS7WHKvIKWSHaZjV7vw/HNjLZ+FqBin6UNpWkmLd/1HNc1XzEGi0wH6nLgBmNTJ6mLJl61/kXsJ5S+YK7jDIfR3Z9sWjFjUo09/tpl/DnecCnhDzPh3M8pm57jyfXvAkCCDV8maivbiEw4xY3DJmav+EcrWpuqb9Fau5UxJyK4EgBCXR9wBpkLu0TUtLtE3d4crLsKVG8k/jNXU65oZXL5/fCAuGjN6N3kXU1/Q==
X-MS-TrafficTypeDiagnostic: CY4PR1301MB2023:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1301MB2023;31:BIfk749RuBMxEkkVQ/MwxwKdb9Nwk4wL2vqygsZyrFHaHr/+xk2IvlHtgUQufyOctYvCwkQie2ZKhJtJA+FJt/6eY8gbJidZlBreVeqtOo9r51JcknJwlVGIbOVJ8+tBxIRX1RTIDuJxJkCiIJOXK3JZjtUmnF0FDL5TxC2/ZOjSuJo1pG+mY2PpkxkvI3jV6b/UC6v43U1wI2lw3wMt2pChNWgZDJdEsjmzJIaHIy8=;20:mWW9rERjL3GahFHlvT4UMUY0D/J9hvOVaffnGqDloWx4PEuSJi2OGK2B5qsweSbB8aUagj5Hg0hMpdhuPfoW4/eU0ZLxc34j8otaVIXiIJFFJN44iH7bz1a3eGbLAYi0VwQr98+PfF1iDuFsmx/y3OdMmlnIU6ShfNx/MCVRzlrjia99lrqAGmC5apkgjNjJ8wFYFkl0M2tlG3C0gz2AxtD4BaGV/l0esZWWO7HC1hnZLYfNXr/zmHYDdVc2ejtMh9ZcWAS82kcHvngXplVsrYsg8x53GLDRcmTnXFoogfaCA8duLjQywQnu1b0xaMErPMGyg7GM/3qlMIDCSldS+rBbR0anSnbSWEEtdztMVrLfOk+2T20azsilozGEz1IEjYKQWoXaWXGijTxiiy55P2a9w2Peffx1k78YiWbd0KvnzeKKdOv/opmpt++1jW9VnTMONaZruPJNAfCy+hODkQTLgLSf6yy9fpVgKNdLwnuJuzd8LZAHO3po6ZSN+Y9u
X-Microsoft-Antispam-PRVS: <CY4PR1301MB2023DF001F9C8AB15768CF46FDBA0@CY4PR1301MB2023.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(11241501184)(944501327)(52105095)(93006095)(93004095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR1301MB2023;BCL:0;PCL:0;RULEID:;SRVR:CY4PR1301MB2023;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1301MB2023;4:eG3Rii5ceg5WgmEXf5FRYQlYPWKuytxxzEqGSvKQUcDSlCKWOX2ZksRmfx5CVRjKg4OVAMIYx9lt4tsjA9dxhScLrzApGNp3GKgK9JSC5wNtAsrhwyxc3uY7qB39AGi22NNwn4pB7rkUy0opDM/tKxY0xhi0NpDrMpMnJLg//oou+uRVjL17OgNmT9JEoRP6FwJQ9vkKpGkucSoPxZXB1Lu0auZs6HZLL5eXoM9LyZIv84/vwxijQir8KfZfAyey076n3fGq8MdqdotRrFXLag==
X-Forefront-PRVS: 0634F37BFF
X-Microsoft-Exchange-Diagnostics: =?iso-2022-jp?B?MTtDWTRQUjEzMDFNQjIwMjM7MjM6TDNOVTk3TElyZ3k3OEtzODFvSUJC?=
 =?iso-2022-jp?B?U2xlekFpWWhnYzFNZFM3akxMRitEQXRBbzRsQ0hNNUhxcmgraWJHanV6?=
 =?iso-2022-jp?B?RzNpeVdMLzc3QUhOQTF5MHJ2SEtrSUpiVXY4ODEyeHFKRWI5WVFHYVA4?=
 =?iso-2022-jp?B?SUxtQ0JIb1NXOW1zMWNHaVhXbnZZTkl4amdIaEpyVXQxK21DRzZ0bFJ5?=
 =?iso-2022-jp?B?aFkxcFoxNEMxcndEQW1NcEM4QTl5ZE5yY2lwcXRVODRwVmFacTFEQWkz?=
 =?iso-2022-jp?B?V0w1MElIQ1VaUFNqbS8xUG1vOWczbThnUXc4QWNiWWNrMDFNdzJ2dlJN?=
 =?iso-2022-jp?B?bFZoU1dlSnZwbEtTRUJockZ1enNWTGpINmFBc0V1eUZsbnZWSWlZQ1Jl?=
 =?iso-2022-jp?B?VndjeDRrZVBlRWQvU1BMMEppdUtuN2xWdm94dHFvTXZrOHV2ZVh0dHRR?=
 =?iso-2022-jp?B?ZWo2RnExSitXMENxRWFFaWJVNDM1WTlZVE45R1ZOd2JpREJKbzFERm40?=
 =?iso-2022-jp?B?a3U5V1BsNnJHcnZVRTh1L210enhPbTl4Y0RKN25jd2VOeFNSZEhraWcw?=
 =?iso-2022-jp?B?U2R6YjB6cDdMbUNuY29zbWQ4Z05nUEpsSzJucGFjbFk1c1V6REczQ1FV?=
 =?iso-2022-jp?B?RldCaFdLVHlFMy9OaUJGMGx6NENUWkwzaU9QN1RmTmdQTVJSbE5MTFZl?=
 =?iso-2022-jp?B?Yzh5ZXF1bE9PV24zL0FRWHY3WVBnTk9WTVFoZmRUajRYbHZVZUlKWjdx?=
 =?iso-2022-jp?B?S0x4ZTZ0SHdoam51SDBNcW0vT3A3VHdFQWFjeEV1aE1jb0tnaXRWeU9t?=
 =?iso-2022-jp?B?NXdMejB5TTUrOFl0RWlKWWJ5Vi82VXlzOTdpY01WaWd5OXJpQ1RleTJ6?=
 =?iso-2022-jp?B?OFlINW9FeWdRdGtrZTBXTm1PcGh5ZW5WLzRPNlVvN2ZjWS9Rd1NCUkgy?=
 =?iso-2022-jp?B?RjdYWU1KTExMT3NrTFFPTDlSVFpQVFhZNS9XOHBLVmtsTjF5UDVxUGE1?=
 =?iso-2022-jp?B?Szhxek1oZVluUWNpUk91Zm9EV2hRTlllSmFSajBkY2w1YVArcE4vWUVU?=
 =?iso-2022-jp?B?cVBqVDhZS2VGNnlGUXNiZVRXMlN3OWRHM2hkMDdiaFVnK3dQNW10emdY?=
 =?iso-2022-jp?B?eTlEdmFPOWNpM1JhMmdtaDVsdWR5QUNxeDRPRUNwUXkrRHRoRm0vdWVO?=
 =?iso-2022-jp?B?ZUdnRFg1TzRvM3lnbDRUeGJmV0VWZlROWi81Y1hQZEtNUTNjN1Nwd0xx?=
 =?iso-2022-jp?B?ZVQ5UUhFbE1kaTVyK3BIcTNMOUdjVE5sRjBjbXlodzVtN3VLVUsyYUpp?=
 =?iso-2022-jp?B?MTI0RmU3UkJuZllyaFBrSSt6KzZiRTFYa1k3bjdNS0JiSEJPdFNsNDlm?=
 =?iso-2022-jp?B?bWRtYkZrWVlZNE9kbHJwWEM2MVdaM044ZzVSZDk5aTk0Z1hRWU5vY3Bx?=
 =?iso-2022-jp?B?NGhHN3FMdEpZMmxFQnhNQ2NnWXc2bjJyejdxR3hpOU81NmhSd3F5ZXpM?=
 =?iso-2022-jp?B?OVJWcFNNb3MzaC9sZjBQWVlab3JkSG12L1VoMDJXcjd0cnI1NWMybWJh?=
 =?iso-2022-jp?B?ckNhcG41c1cxWTVIeUFXTkhrdUc2Q3BHR2xYMnlIZEJEMERYa1BwTFpH?=
 =?iso-2022-jp?B?bUQzWEpIQmNXSkNOL05jcVplSjlqK1JTNDV0dFVSL1pLeE9xWnNXM3lZ?=
 =?iso-2022-jp?B?VVJMTjVDNzdhNEc5UlNoV0VJZWhFZzhEUnB2K1dtOEpoN2dLN2lLWkdo?=
 =?iso-2022-jp?B?dW1sVHpwbVdOVWpTNnFFd1h5U3h1OUhXelc0Y1J1MHVnNGxaQUJjNXZ0?=
 =?iso-2022-jp?B?bjZER2JqekNmTURlQ0ZsN3RTZGhLdHVScEZyNWpVUGQ1OEFyVzMzUTFK?=
 =?iso-2022-jp?B?aElHWVNHdis0bFYxb3dqbHU3RzlBPT0=?=
X-Microsoft-Antispam-Message-Info: d3fNa/4EDomEiH/e9v3PdYhmfj/j/xb7m3G+zrLxWJ1BPlD5OFy1rjJQd6kxOTAenZ8lV5f1DNBogNn2wDE3dk8qsW/j8DMwdhygfynqookMElcY+yFKJFLaZyL1+MAj/rYIq/8yw7Af/ezEv/q2FLpn99nVQ564twOb+ytTy0eUyVcdo6ddf6HM0n02ZDYK
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1301MB2023;6:8PgeoRQ8XICt2y6vfHLfsceNyQEKIuQtYIbtSN73upXRqYIX9CX9NjZnhEQIWPPBQHgTfvugWNfLiwOXx1gxChdMFdGmeI6R72wetz7aTI9098RFueRHf4mbx8ZOw66tjFSU4V+TxObhzv+Y0iAacLvh1SBKpjS/IXgL/bJbZKqEuXPUeCeOze1CQ516/2wxY12ujwjC79Yi0+zcgl6WfdX1FU/TQgmXIZzEsS0iseMICMqlp20HzA0tDtnu4P4uT0tDXFtFmdiaN9ago0vMl5nSvXYJh/Oj39h73VoOh2QeNv5QcuyJxrKiv3vx9c/l5zDk4+DPBoWfj5LqOolbkPcjXeF0Ij4HY47GoCTB/mIBN0L1SOT01Hy14jPD262zHx7uRbF/NCZ3t6qjYeIvp1eOTjv2VYRmg5wX792yiEv9jARyG+ar5wRAuEtMq0G9p7eD3aB/W/Udu3ENyajVMA==;5://e+KT/IFKSZ0XCqgwMfNtioJXSfCgUmFSCFdrjjj+KOCg92+2XlgiCnNk/5u2vHP8c+5EW3OkTAwJz5twD6aC/qr0HFYJrcUwMQFC7i6w/9rxjS6goiVF7BH20URqRppaf5HWvn/PrdiQr58jWf9Qw2dvUoDg6wM6rGThGCwUQ=;24:4FFqDUUngvADrMRmZtd7pL8eA11h2BeOfUm+ZKCwTzakL7cydFlQqmOYiD4e9CY5eVTDklDIB1QLOfcparffVDGL/0Ni4jGIY9rGw7G1ktE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1301MB2023;7:cL3HAQALxdwy78FPRfJRKDLauRElypy+Xnp40J3oqOhGRD5rxvt2HIJOqeq01NK6xcIFyYU3r6UMxEwAnYIeNZx7LC1ncA3rEqII0cTEpKBMQ1Yg8z9HuX7/ixjQNu6fGGAmmFOxquTtPtAa6M7Uwd6/lugQV+JGvv1qw129IV+6qJ04lsQCN+5CV8qeyZnam+5q4hjxsmRVwMLZ9mAm6ZKx1JCxdUShlX33Q8wJ4NMnd8Tj3RQK+73lGsAq09bu
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 00:28:51.9644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e0e13f-bdc9-4004-786b-08d59b555fcb
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.42];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1301MB2023
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,　Mauro

> > +	u8 send_data[BURST_WRITE_MAX + 4];
> > +	const u8 *write_data_top = NULL;
> > +	int ret = 0;
> > +
> > +	if (!spi || !data) {
> > +		pr_err("invalid arg\n");
> > +		return -EINVAL;
> > +	}
> > +	if (size > BURST_WRITE_MAX) {
> > +		pr_err("data size > WRITE_MAX\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (sub_address + size > 0x100) {
> > +		pr_err("out of range\n");
> > +		return -EINVAL;
> > +	}
> 
> It is better to use dev_err(spi->dev, ...) instead of pr_err().

I got comment for this previous version patch as below
--------------------------------------------------------------------------------------
The best would be to se dev_err() & friends for printing messages, as they print the device's name as filled at struct device.
If you don't use, please add a define that will print the name at the logs, like:

  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

either at the begining of the driver or at some header file.

Btw, I'm noticing that you're also using dev_err() on other places of the code. 
Please standardize. OK, on a few places, you may still need to use pr_err(), if you need to print a message before initializing struct device, but I suspect that you can init
--------------------------------------------------------------------------------------

You pointed out here before. Because dev_foo () and pr_foo () were mixed.
We standardize with pr_foo() because the logs is outputted before getting the device structure.
Is it better to use dev_foo() where we can use it?

Takiguchi
