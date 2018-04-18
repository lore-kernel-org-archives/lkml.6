Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753098AbeDRJXK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 05:23:10 -0400
Received: from mail-by2nam03on0071.outbound.protection.outlook.com ([104.47.42.71]:14368
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752514AbeDRJXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 05:23:07 -0400
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; the-dreams.de; dkim=none (message not signed)
 header.d=none;the-dreams.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH 1/4] i2c: mux: ltc4306: switch to using .probe_new
To: Peter Rosin <peda@axentia.se>, <linux-kernel@vger.kernel.org>
CC: Wolfram Sang <wsa@the-dreams.de>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>, <linux-i2c@vger.kernel.org>
References: <20180417143233.25145-1-peda@axentia.se>
 <20180417143233.25145-2-peda@axentia.se>
From: Michael Hennerich <michael.hennerich@analog.com>
Organization: Analog Devices Inc.
Message-ID: <bc5637c3-5e09-b01f-8b9d-f7dcb3b578e1@analog.com>
Date: Wed, 18 Apr 2018 11:26:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417143233.25145-2-peda@axentia.se>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(396003)(346002)(2980300002)(438002)(199004)(189003)(476003)(478600001)(36916002)(229853002)(77096007)(26005)(8936002)(6666003)(106466001)(426003)(336012)(4326008)(53546011)(2616005)(126002)(67846002)(44832011)(36756003)(186003)(43066004)(2486003)(23676004)(86362001)(72206003)(575784001)(11346002)(31696002)(8676002)(76176011)(486006)(446003)(3450700001)(316002)(65826007)(58126008)(54906003)(110136005)(65806001)(5660300001)(47776003)(50466002)(6246003)(2906002)(2870700001)(7636002)(106002)(31686004)(64126003)(305945005)(356003)(65956001)(142923001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2482;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;MLV:ovrnspm;A:1;MX:1;PTR:nwd2mail11.analog.com;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD019;1:Jp7LO+OcZ5QqtDBwPhzhwUwvEuHUXRFCGd85q3We6iPlCxOnTZxPagGSR2hI2mYZosacQElSOcYecqSFIC/09VZIxmWAHBELUBvq5aqqPDBidRGjDCo6TgzvMeGK4rtN
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN6PR03MB2482;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2482;3:QF9eTcg43tEkeWlbmtc7hNRHvs5LvgS8MbWoioH0PYzVlk0hCyaDue9JnVPGtNi4cKAfi9e++Zur+bONS10GnrEeyrjdOcUJlaLzDXnr6kOKzwAJZrj1lfjQx0fMOqQyPlMKf6HoBz6rnPLQ+nbkUb/r5huAwa6UG2O9YzH8QSLCqw+Y+5F8BAXT4zRjrX0m71GDdJHbtS/cBw6A4JrxqmwQpmTEKQwgJWxInmw9Ud4cyhupj/g5tmeQj+TRnmWO7Rj5er8fahCDMXZxnih3tU1ieYjjrWo6lE3b75BN5YXwZK+EZwEFp/Oh4nagkSOY2LubVtBgEiVIk/IlaVRs3gUyFZeFZIEhXQ61qvJAmDw=;25:8HaQHIcz/23s6l9dhOeUTa1p9S2Z2Suj8waCKY+jypvVemrVphkKukfpeK4zxxJ73xicPkDbKXChDJpf6ZG1n0tsNmbCNS5tVuPv0vui+7K5nKfvRwzCACvVXoSIh2V0EDq7QpLWA8uVt4smMdhyVn6RcvNjJUnZpxjlq8obrRk91kzwtZ1MmMSogolUNmi6Il+dDdeQseLnRPZQrli1rgr56bgsiCljgHGs/28vu/4qjwu9Y6VmtMKB0ZoFXoqhyPrLFMAi1KjYKpHqgztDF/Sz2Q1MyLNfdMuqknp0IowKqLhn50dS31A1i5R38E53al6WwG16AZFqRIWb1OP6kg==
X-MS-TrafficTypeDiagnostic: BN6PR03MB2482:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2482;31:lLoDWJkJxDBVYiXncZmeqsHJeN/1ugCuyewcJrtUahq9U62IeHjmVg/nSdFrSYPOTo9yETG7tXSZ0DVlsDnd8LdLH+b2lX3h8V71EjhcLoR5JUW/bTxG6P21iBRpopyBPLBcRzNuu+rvDzWdWfwIu9Y2R9vyRwAdCP+UnTZiho+1Kw+AMMv/HiY/18lNB0Gi5eInkSwNR4hZPVSSB2yCNAz3i2nLFVRsjhwZslUW43U=;20:K1/SVrqGjM3S8oOyxKovtY4aAdlrqyJ72fFMQAFrFNmTN4mMPqp9hQ/heD/fB0O0WDCoE7LBGN9aDh79rV4e+R9V57REkJELMhb2VXr4Y55Ku2Hi4zvFck9Ud0kvb7m5yyPL7two6WFDDDx5O+NfAA0jBy9GWlakKgh0BugzJ+tzcggPvH8/zNoz5KZXMuQZoEkKulzrdPSqhdO3MzEJlp1Nmvz/lMrblEcAfZCQLDcH8LEsFrVITe4imr8HdrfHiKJIQVOPbac53qcWuSRTKqOIVk1fF2VN9Dmzdaz1c40OD86U6RnPBW2ocjzglNckJ1W6vzmVR+dI9654EBAGXv5+Hd//rEkFSzbCgorLhJ1keIBJy2xYKwmCSTOvtx1VUyoqSJ/xHz9BsRNsoacR22P7YrYY2CKPlr44wh/VK5VkvqVpH6BFMd0KgVpize0zJuSRt3eZK9TJw60uOu07elwIzMxYBswY/AxiC/uBgteDQyb0Kt7j55BzWhh6Y+Ko
X-Microsoft-Antispam-PRVS: <BN6PR03MB24827ECB9AB4658DC13765AE8EB60@BN6PR03MB2482.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231232)(944501368)(52105095)(6055026)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR03MB2482;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2482;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2482;4:qW6Gyrf/yn9EM0i6OU+Z3NtuJ9OemFoOPkvyh5gn7I8sPFoKtzl8WuY8yNadbk/OmcbafTXNFXcu9SgGnsbZbZv1Qvg0qqbofAhP++zNpOYv9cc/H7K2zCzNlUISACev3pTzBsZR67I2Mgihe9zV8HFx99vGhGbvZa5toxKKHcS3jP1xjERBXMAfIemB5HpGSXqs93yuvzYtSJbgYnL15gLh/c+C3Of/VOhSPWdwIBD39BjWpw3BNpL9sckhGBEk1Ga0e9YTZemv2UtGN22QViJVz8hgiUvM5baPLUJ7DMDeQ90RtDagO+YfllHDY+US
X-Forefront-PRVS: 06469BCC91
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAzTUIyNDgyOzIzOldreU5TMUVYRzR1anZ4dDN2bllkRHl4STFq?=
 =?utf-8?B?UUNCUXBEakpuRENsRzB2eHhxS3VkUGRmY0tEK2xvQUs1bEFhRFRsS3dyWXg2?=
 =?utf-8?B?eGFicnl6S2c1eExvSjZoMXBGa0pWZjNkNHdETC9CUTRhVlRlU3VVRzkrTDBt?=
 =?utf-8?B?T3FMWUJhaEtKYU5uMVZjOEtNK29hbk5XV2hqb2ZtR2lHeTVLY0E2YzdUREts?=
 =?utf-8?B?Y25wbEU5ZWk4UldyMWV4M2hNM1BBOG5vSnZDSjZ6NVlqOFlURnRpVmNuUkxx?=
 =?utf-8?B?Uzh6RzlaaVhUYkkvRE53VFpGeVd6NVJlM0RYT2ZRSEJqWXZmV2J5WWNlVHUr?=
 =?utf-8?B?NkZOQ25NT2tCVkgzWlh5a3F3WmwrSlVuK3lEeGhBMW5BdkNjK2FMN2NxOUhP?=
 =?utf-8?B?NW5TTUpEbVZoNTg1Z0lsKzNtOUNaK0JWNkxkcnBPc09KZmVOMVh3Y1hXOC9P?=
 =?utf-8?B?ZVFzUWMzOWFzTkxnUC9NUWRBTGhOMHE4dHY0Qnk5YWpTaUxjQUFVNVcxNGJ3?=
 =?utf-8?B?bFIvVGdvazYwdnlhM21sYThpYmJLNCtxeHBTOGtTYXBZa0JiN2UzVEZSWHI0?=
 =?utf-8?B?SndLcUg1TWoyL1c3U3dFM3pucENXMGRsblYwTkF2MFpqVEhkSUtXVnhsTGZ5?=
 =?utf-8?B?WWg0cFkyYzZmZ0J2TVJtNHEwTU1wR2QybEdCbFN3cHo4VmNJR2RpVDJzNmt1?=
 =?utf-8?B?bHRFMkdvaXBYOGl0RWlpT28vVHlDbENFcklIUFBFYndaWVFnb29IUFlzaFBS?=
 =?utf-8?B?Qi82R2JWcUlpdVZySHR3ZHZyVXlteXkvMFRZcXhNWVdkZVJtdFZZV3VKSWVU?=
 =?utf-8?B?VnVlTE9HMjhKeXhERWkzL1Q5N1BKYmVoWVNmSUNPMStMcVBZdnozUzJMb3ha?=
 =?utf-8?B?ZUJDYlhwVjFIRU5vSzZaa1RkMWNDbTZMQjB1anRyQ1kyVjMyMkduNkNRN1J1?=
 =?utf-8?B?RjBlRWlKbzh4UExHU0EwZTdubHVWSDdrWkhmbE43eFU5VlpWcFBDeS9GMGlw?=
 =?utf-8?B?QTJmVVF2aDVEa1BiRW01NHE5OUlmQXdUZ0VqaTJYak9lbTN0VGg0emlUWFpv?=
 =?utf-8?B?UjhrWUlDRTlvdEZvRjZhbWltRldRRDVRc0R3aXZGNWZ6QzYzNkdQNGQ5Qy9U?=
 =?utf-8?B?TnhCeEFEK2h0cXJTSkxBMG5jUStZVFFnQ1ZyYTBRclNRQ0ZNdFducENpU3hx?=
 =?utf-8?B?MWFia0VCckdqT1JnVVpBRjYzd2lwelVOcVJ1MEpjNXh2Q05TcStkSklQNGgw?=
 =?utf-8?B?VlNXSmJkSmhydzJwVVVPTFhtbjZYazk4bmRaZzlhNWxQaXdqRytKWERIRm0y?=
 =?utf-8?B?QTZTRDV6KytRb3EyN0t6ZG43THM5WUxEc3REWGM0dHcvNWZOTkZFSWFOQkRV?=
 =?utf-8?B?MjdNRmp0MzUzQkduY1F1SHhUNEs1TmIrL0dUYWE4K1AvQ2JxOWcvVHNxVyt1?=
 =?utf-8?B?SXpyY05LaktjQm43aHBtamZUeDY3clF6dDgraTJPVU1ZMXVyY3NreTdhZVRH?=
 =?utf-8?B?L3cwNmhIUWExVnhXaU9VR1JBV2swZmY0ZjJDaWFaSWJPdjNHOGI4VXpsbXJn?=
 =?utf-8?B?TFVTSW5JT2xqWWFKU05qN25mZmlOQlRYTDI1TUNwVkVYSDVSUGZlcERvNzdV?=
 =?utf-8?B?RWYzY3k1R1pwdUgwZFc2K1dXakpqbGg1d1I4b3ZKUUVOUzhtT1hDdUxDUWR5?=
 =?utf-8?B?aFJpYkM5UXFzaWVQZUU1ekNVR01oSzU4Y244VFdBT3lNS0JHVG10R3VjNTNa?=
 =?utf-8?B?ODhvaDREcVBoVGViVEYvTEEzRkZmSWRVdmVGbTB1L3JONUVRVVRBeWJjOFI0?=
 =?utf-8?B?ZTlOaVp4bUFjQTFCMjY0Z3EzdVFvMGUxN1hXaEhiSFIxb2c9PQ==?=
X-Microsoft-Antispam-Message-Info: GNGJ135X6dU8CfJU0UPQ4ZgdAmgjz5RTUMN1/WsBIleNZcnDdrXYOttzjB/G/zfYPVCKxw6XDqKl6GXGXtRyxxjHSwmncTPk0S16HO6Xzrd3biJCUTBY3pX0+f4n/aXn0xP9xseYKGGLI52Ln+AA1AEz75zmEHdRGyMEW69/YVdCoXE322cwGxSIeDj6zEsD
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2482;6:yJaYYMO2wXBO8a2mjMvsIz5SEmPsyqOvvVWfnV4x/Dxa6fNIVjBAnS/Lw5/axKmsYrCVfYDizNZgotbpBoLh7RMwI8SShD6koCTYyA2vKwSSH5e732s3D5m5PSm4L0CCPjTV9CbEWmEj+2A12YFSxIHy4fH6KAhnSxLA2aqhewUS/cK8GD/ISY5hH5eRXlclw6TJMQjx/MPNNmJbiQOuR8KITwtLtfPf8Vmz4BN9N/U+HgRAP4BRj5wtcQJHxc48cISbTBlwSdox+yqi2e7FtBG64nvtYSm3S1txY5Xgh7iOkzsgYnMGdniubqeMmNXU4mH79EjgfgLo7d6QbEw2rBmYSxb0cL7Qk50vln8XG/105EPDPkw+v2XfB5oxsYZkLKn5cmDr6Cd37L7gv7dkoicgW69523mtG9yTh4wpZluu24iF7aaeN1Cic5po6cnOTRu+1A93GuHuTmqkzHcotQ==;5:LeOJVuuj4dMHTCaB+fIfQrgiug4ekXcPWm6QCYUTcV5sKJLzjOH+qWqYvnsNfgdTVRPxIiTyYf4B43a6pwZHOBhR1mlEtRwcCmi/bMncnMwM5txSQ/hH9wdLltVUovKRmzDnseFL00ok/tpUDgcgiLNxttbihehOTzH/MsdieT4=;24:jQXtCCpu+f0uPqVM7OtGVGAtT//KgpUpZ+Iw+qDkWCRo9cBowuKa1ZreyD00cC18zoXnCkb/TjHVyR7UVHMR7a+duxpH0ZQFUsELIH0S+/U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2482;7:lCiPBtCxJ59fx7tPlUVr3Babj2PUvzE23gAmWV1BT25+xFrF6NROVsmX0j4Az2LYcjZDsS4BZr0S6JvVOYYsUdOcPwRslnctAy/flC0ZWJuT8lki9Cm01rBYlMp5PhYCVn3EkRwIvb0aXlLbiXee6j6Xv76rAZsnSrzNwscflKJ4KdFQY00e/iPBW8KVerhe8854tQ/oOstVGKhXyK3bVgm9mgI2jrpbMma+jF7WIwYKaOU0eIfa8TzzZz1SDTRL
X-MS-Office365-Filtering-Correlation-Id: d45c2404-9fc0-4389-92c2-08d5a50dfce8
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2018 09:23:01.3311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d45c2404-9fc0-4389-92c2-08d5a50dfce8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2482
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.2018 16:32, Peter Rosin wrote:
> Use the new probe style for i2c drivers.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Thanks Peter,

Don't know why i2c needs a new probe style to save one function parameter...
But this patch looks otherwise good to me.

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>   drivers/i2c/muxes/i2c-mux-ltc4306.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-ltc4306.c b/drivers/i2c/muxes/i2c-mux-ltc4306.c
> index 311b1cced0c0..a9af93259b19 100644
> --- a/drivers/i2c/muxes/i2c-mux-ltc4306.c
> +++ b/drivers/i2c/muxes/i2c-mux-ltc4306.c
> @@ -206,8 +206,7 @@ static const struct of_device_id ltc4306_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, ltc4306_of_match);
>   
> -static int ltc4306_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int ltc4306_probe(struct i2c_client *client)
>   {
>   	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
>   	const struct chip_desc *chip;
> @@ -221,7 +220,7 @@ static int ltc4306_probe(struct i2c_client *client,
>   	chip = of_device_get_match_data(&client->dev);
>   
>   	if (!chip)
> -		chip = &chips[id->driver_data];
> +		chip = &chips[i2c_match_id(ltc4306_id, client)->driver_data];
>   
>   	idle_disc = device_property_read_bool(&client->dev,
>   					      "i2c-mux-idle-disconnect");
> @@ -310,7 +309,7 @@ static struct i2c_driver ltc4306_driver = {
>   		.name	= "ltc4306",
>   		.of_match_table = of_match_ptr(ltc4306_of_match),
>   	},
> -	.probe		= ltc4306_probe,
> +	.probe_new	= ltc4306_probe,
>   	.remove		= ltc4306_remove,
>   	.id_table	= ltc4306_id,
>   };
> 


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
