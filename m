Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeDKLov (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 07:44:51 -0400
Received: from mail-eopbgr50103.outbound.protection.outlook.com ([40.107.5.103]:18512
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751491AbeDKLos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 07:44:48 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 4/4] eeprom: at24: provide a separate routine for creating
 dummy i2c clients
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sven Van Asbroeck <svendev@arcx.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180410131206.25760-1-brgl@bgdev.pl>
 <20180410131206.25760-5-brgl@bgdev.pl>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <25fe025c-b6cb-e8e9-da28-55ca17ce21f7@axentia.se>
Date: Wed, 11 Apr 2018 13:44:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410131206.25760-5-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0359.eurprd05.prod.outlook.com
 (2603:10a6:7:94::18) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:831srnRXBL1PBETb4l+IncmyXOsL8S1y58M7e1JRsMpI8NngujPU4DnR1uBPqCp6uM/j7eUNiFL0U/11c0TfvdD3xGZU8W22GS6yS6sxXhH+thv3CEX9riYLFXOzLF9W+eJNunsI+Ju8YyXGeMA5WSg64VtePe1e0eHVS745eGh0e9nx7YcFLwXFQvmeON43oHnCkSRhYz5r+eLMPNN1stfhoDGrypGzh0AZOp0G4IyBhGYRGCtde5anh92RCOt/;25:lXmPD+sCPI5CkIiatT+x3qNbcKVzJFVxblPa+JHCIYaoydS0Ov0StAvfmBaa9FiIcdbQSrttbd5opyE7tIeFHvq13bgy+zhDl1bBq9Syqe1gQSn0wKszUpsE8naWpoBvmNDoP2h2wm0BEJWt+Kc2wsUd/Dx23bS++Jk6sLozvkIaVwgJN5WWmfhbP9omdljYuEwtcDhPdG8ZflbYhs+j4kfl+zfKL+EDYt264dTPlx93ap/2Si+kqvMfZ2+oQwYwlcUp/H5bcPtG92cPrz5PDiu9k+exTxxR2lUP/S8WRYNwHYaq1zmNfeJniNmVVv5Jk2Qz38uPCxvTAP8XG01k8w==;31:gcq0woTCbzzpkaWBMibjkUxpslAXSl32HfyA1VOAUs8vUR63nfTMip4Cbw1J0QhjZNQoOp6SHZ9kks3XiFJCQPaKXF8zGj2Nnmu7hZqG82IROfVqshUY/hICrrD09PdJeJ68SizJPA3wCx8H2GKAuxCW0WtXEbUvasnckauytuZ/S7PX/Kg2byxxLg93SsevA0nu65qqT3HJW55GSMr2MVXfNOj423IoNsGUPe/BH1k=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772F6E12375A376FF826731BCBD0@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123558120)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:Vwvq+zFAu5lB/n7YpSqkxScvLjE0CsZZgfY0D8a7W9Jj91o1pqmj1t9vaIvkXej1oEUfAriZEViJbM9zFsBx/z2FomCFfcAUqTrlFYdgy1S1P2lBZs/Bk9AmmxZSXAv3101eZe8/j8hFMgtReOruKR5tps+nboqWIfE2zGe365tfFSp8aQdn5BE4peqK9YMC3Cn7zE4550NrwvHX6v8gUUV+sQVe/6Nd+9dZyRP7i0GEmINz6e0fZZWZs2b/QwGS6yBX7ScaYA/cag/f+yNWWA==
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39380400002)(346002)(39830400003)(376002)(366004)(199004)(189003)(377424004)(230700001)(106356001)(65826007)(64126003)(316002)(956004)(6246003)(11346002)(5660300001)(53936002)(2616005)(486006)(58126008)(39060400002)(446003)(16576012)(305945005)(86362001)(31696002)(110136005)(7736002)(97736004)(6486002)(36756003)(50466002)(77096007)(186003)(229853002)(16526019)(52116002)(3846002)(6116002)(68736007)(478600001)(2906002)(36916002)(23676004)(2486003)(31686004)(4326008)(105586002)(6666003)(47776003)(76176011)(8936002)(8676002)(117156002)(26005)(25786009)(65956001)(52146003)(66066001)(74482002)(81156014)(53546011)(386003)(81166006)(3260700006)(476003)(65806001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzI7MjM6aEVxWFJLcUg3Y1kwdEJ6RG5GMyszSDBP?=
 =?utf-8?B?bmtsMmFwSjBycFdnTlA4T2tHa2JyWERzNnl1OTZaa3RiVkcvWUhLbysvZk4x?=
 =?utf-8?B?amtDUk1ONEZqZU94TWk4YXpGZitsUUUvUWhrZUVvUUlCamdQdzd3cTloZWVX?=
 =?utf-8?B?UWc4SlJ6NnRzWExzUnpTcjhSdHRjaURLbkl2RmgrSlV5bG1rYVV3OHJlNVBG?=
 =?utf-8?B?czJGb2N2bmh4ak1rZU9lRkovSE92eWRoTGVuZ1RKQWNlay8wSXBGOXFVNUFD?=
 =?utf-8?B?MGdDb2RjMjNuWEtRQUpzaVo2NFA5VmdEL2hKTTh6QVVZcTdGb1FMeFBoVTcy?=
 =?utf-8?B?L1d4RnZtWlNSVTEzdDBoTVBuYkpEL3JRRGVZT0xVd1JOS2szL0dtRkFER09t?=
 =?utf-8?B?RGFwZUhPZHhKbEJXMXJ4eGZQYWJ2dW5pMVQ3UkM3U280QUxPMU45TXhBRjJF?=
 =?utf-8?B?cHVHYzlpQjdaeXN5SGV1ekdlUlVCMmViREpqSnQ4Rm1UNmtMbkRIZjhWMzZI?=
 =?utf-8?B?UzROKzVGS2p5aHptODBQajIzZVV5Z2NiekNPcFU5dnRxTlo1cFdJWndValYr?=
 =?utf-8?B?YTNudnFIenFkSE9ReFViWkdmNlRVV1k2STlSMFc5eFVpT2lwUllWSlQ3MWtH?=
 =?utf-8?B?c2h0Ynk2blNOSkFzaHZ4enJ2cm9lc3p4bXlyNjJVS01ibCtSMVh0REtQWVZp?=
 =?utf-8?B?dm9lTzd6cEkzN25mcmNiRnUzem5iT3JGNitkaUpGd2hQMlUxeXQ1RDEvZWZz?=
 =?utf-8?B?Ym9CaXVRTEhLd1NlbjN0d0QySnZMbGN1bG5hY3FvWHdBT2xtWGRacFk3UURH?=
 =?utf-8?B?elRjSEJpWHAyQ0VTbFNlSzYrUVZoSWFzdmpTVjU1U1JnanE3dEdqQmdCNFFx?=
 =?utf-8?B?VHBoTGUzeHdLMmsrYmdjMVZoT0NNcmlDeEZhK1dqMHk5MXNPNTdSR2pBNW14?=
 =?utf-8?B?OVNEcWpzSGNISkhXTjZjQ0Y0RzN0cFFmOFBhWVBFblk1YjIveldJSGQ4L3hI?=
 =?utf-8?B?ZDd0clRmeVVpUGZ0eEM5WG5FZnNPQ3pOcmVqOHFpSmFsTWVscnJRaGxEVmh4?=
 =?utf-8?B?bEgrZ29VWGZ6NmF6dng3aXp0ak9Gd0RDSjNUNGpQZkp5YW9iSGlsbVdVL1dV?=
 =?utf-8?B?VVJWWUR0Z1pMY21RdUJob3hndXcyNVpadXArbFFIM2IvdE4rdWFtSGFKNlpN?=
 =?utf-8?B?Tys1ZkluTmoyTFI1YWFDYVdhUWJORG5xc0VnUGgrbmF0M3hjcE9OUDVrWmlY?=
 =?utf-8?B?czRBZFNSS1N2SGF1UHM2MkhTTUVHSzBOalpKb1RjTmxGbnR5eHRVOEhXZ1lO?=
 =?utf-8?B?OTlZSHhtY1FIaGY1QnNtYUJoL2xTcVo4bzcrUHFSWFNPVSs5cU9TdFlIWU9t?=
 =?utf-8?B?MlpSVkZYck9oN3pNNWkyd2VoNXNvUy83b1N0R1NQNzgyZklJM1g2SU55YWZU?=
 =?utf-8?B?Mm83S1N3aktHYnh6dkhET2JOYzh4SGwxQWZZbVB0Mk53anFqUE9KRzc3NVRV?=
 =?utf-8?B?TkZQSzRaclVuVjhkQU1CZHljdklXY0p5SWVRVkNEQWpRQWFHbXFOOUVUL1Nm?=
 =?utf-8?B?ZjJGNFVPUm1DdWN2QTIrd085YXF2cjNtVllMeWJRZmJMei9CaExBczE3ZEpq?=
 =?utf-8?B?dERYblRwMVBjaWRObGlqQmVkR0xpbnVjUllYQXptSHByVXNBZDdkMG5GTTZI?=
 =?utf-8?B?NmpkTHNxQ2JLaVVSNmpXQ09aem4wMzhGa0o2YXh5ZzBNMXBBN1NrSXoySUE1?=
 =?utf-8?B?bnZBREl0UFc2elNnL2wxb0VvclZ2YWFaVlM2aFlYckg0dE9OcGhTUGppbUxl?=
 =?utf-8?B?dVlsQVJvQVdzRkxmMHczWGlrQXpQQ2EzT1ZUcExyYjJyQnc4SGlHNHorSjFL?=
 =?utf-8?B?UUVSOEk3UG1HMWoxYjY5ckNyRExCcXlVNGpUTmFXUEh2WGZPd3JPLzZ3MUVl?=
 =?utf-8?B?K0ozbjVHYmJxTCtRL2ZqMWFjeTRhUm91aHlEaUFtVjM1dGhsN0dFQmdkWXdx?=
 =?utf-8?B?d09ua2kyeEpCQXdvdkVUWVZpdytZemtPL2daLzRTRy9HYTQwQ1BqRUJTcmVK?=
 =?utf-8?B?REkzby9PMUF3aW5UWkpJZU1sRDBEVUlibUpndzZwYWlrU3Qxbi9NN0RDS0Jq?=
 =?utf-8?Q?YhQgGX8/BDOJc+MUHkx1VAEQ8=3D?=
X-Microsoft-Antispam-Message-Info: xaN3otfD0ERZxyzM3CiLdaJK7UakVsLu2Tb8CunRzz6TF00Edf05Zh5VyVanQ3xOQ5va67PcgBy0b6g374wicbLCzs/6oJh6Bu2oLsLPUf0Kn6o5ims/9Qt1Plvn+6Iw89b/rZk+f15OAp+wqJGGIr/i9QAPdGr/yCaZLgPeOH9s1ij7ck6w/WVtdJE0BuwB
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:VhH7+4NR8uEEwOYmlv7KoiSEx1WlkID5PzfvtHh9OfXlVIFPvDGXEXSmf1q+nNdD+DpnCJLWsQICUPu0g6RPgqMGOT0t0fYMeTeoMdnaGg6M6Hk82PRb+FK9nopcZwsvDeAL0xJasmOH0nQxIblBIsAqrSt6wQtJfyRbocSBi5RsLrnjoHzjm8E0CPHESG/a1PDAS1FeG/BhRs+csG/GGJx5cyOwuU4hdIxTqa1RwegMZzQZoJZAL057DLyJ5BsgytGJV7yG1qsjo0Mid5Yx8uFhXG/m4OkDn6KVzA0npRVG3BbD4pp89QrKDanW9J97a8v2CYSFJUacylOx3IxELfdmQZL7Utal2yaonX5V1cPEe1RJndG9PHVdnyOS8ZSVGqOwCO5doS53IHNTVnTXQqazh3WJzIvUZ+9k+KYczICq7QO59d7q1QmkwEGg4o/C3iDrnK4tJnnVAbwIwbIs4Q==;5:8HMFt6qJroGqzdmBeZSPXA8yBflLuKbbOBOpjBIvALF7ZlFZcmBbXvYsO7tyOr5lEvyGucaE2it2JC8WPIsF44qzJ6yoAqnU2q/0i7/E+pjKfCXovJf6QdWxHXbrsiZ1QerfxHiUBUV7Q+G2zo737rXAhpTo/H09oNZZjGp+pRo=;24:XFgyDafYN4J6CvWqKccFvo2/1rU9oLXVTIjm6/8Xq1xNNAXdh2x6QoAMYTArJFnCtG7IZUYFQThXloiJCRXGL6V0x629HV1byqFGGxMrK8M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:13A03ORgaUFSrRmx2Xlfx7OwMDzHj1I3M/dNZOQR9/6oCwmWymQs6oYpdHRvPkRQnW6Hg9muWSaNAENIEMFc9AA7kPJg6BGlgQ75SQO/vQephN2twrIkrRcxL0SXNZqPw4Wf+CeHq2p5H7Rk6iKAVGPGX3qThSM6TUaUaAcqcISEyr6qJtgotKsqjgJY78e7PXOI0jieSXnj6SzuEEMfALJKXOqURijVfQcgPiR8PaOHmww5cu5iNqTtF5746rQS
X-MS-Office365-Filtering-Correlation-Id: 552521b9-1e41-47d6-bad8-08d59fa19f3d
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 11:44:44.9060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 552521b9-1e41-47d6-bad8-08d59fa19f3d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-10 15:12, Bartosz Golaszewski wrote:
> Move the code responsible for creating the dummy i2c clients used by
> chips taking multiple slave addresses to a separate function.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/misc/eeprom/at24.c | 47 ++++++++++++++++++++++++++------------
>  1 file changed, 33 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index c57eaea181d8..0cf79ca4f1bf 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -540,6 +540,35 @@ static void at24_remove_dummy_clients(struct at24_data *at24)
>  		i2c_unregister_device(at24->client[i].client);
>  }
>  
> +static int at24_make_dummy_client(struct at24_data *at24, unsigned int index,
> +				  struct regmap_config *regmap_config)
> +{
> +	struct i2c_client *base_client, *dummy_client;
> +	unsigned short int addr;
> +	struct regmap *regmap;
> +	struct device *dev;
> +
> +	base_client = at24->client[0].client;
> +	dev = &base_client->dev;
> +	addr = base_client->addr + index;
> +
> +	dummy_client = i2c_new_dummy(base_client->adapter,
> +				     base_client->addr + index);
> +	if (!dummy_client) {
> +		dev_err(dev, "address 0x%02x unavailable\n", addr);
> +		return -EADDRINUSE;
> +	}
> +
> +	regmap = devm_regmap_init_i2c(dummy_client, regmap_config);
> +	if (IS_ERR(regmap))

AFAICT, if regmap init fails and you return early, dummy_client is leaked.

> +		return PTR_ERR(regmap);
> +
> +	at24->client[index].client = dummy_client;
> +	at24->client[index].regmap = regmap;
> +
> +	return 0;
> +}
> +
>  static unsigned int at24_get_offset_adj(u8 flags, unsigned int byte_len)
>  {
>  	if (flags & AT24_FLAG_MAC) {
> @@ -645,20 +674,10 @@ static int at24_probe(struct i2c_client *client)
>  
>  	/* use dummy devices for multiple-address chips */
>  	for (i = 1; i < num_addresses; i++) {
> -		at24->client[i].client = i2c_new_dummy(client->adapter,
> -						       client->addr + i);
> -		if (!at24->client[i].client) {
> -			dev_err(dev, "address 0x%02x unavailable\n",
> -				client->addr + i);
> -			err = -EADDRINUSE;
> -			goto err_clients;
> -		}
> -		at24->client[i].regmap = devm_regmap_init_i2c(
> -						at24->client[i].client,
> -						&regmap_config);
> -		if (IS_ERR(at24->client[i].regmap)) {
> -			err = PTR_ERR(at24->client[i].regmap);
> -			goto err_clients;
> +		err = at24_make_dummy_client(at24, i, &regmap_config);
> +		if (err) {
> +			at24_remove_dummy_clients(at24);
> +			return err;
>  		}
>  	}
>  
> 
