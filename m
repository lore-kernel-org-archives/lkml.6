Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeESV4L (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 17:56:11 -0400
Received: from mail-eopbgr10127.outbound.protection.outlook.com ([40.107.1.127]:47424
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752637AbeESV4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 17:56:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 1/4] i2c: mux: ltc4306: switch to using .probe_new
To: michael.hennerich@analog.com, linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org
References: <20180417143233.25145-1-peda@axentia.se>
 <20180417143233.25145-2-peda@axentia.se>
 <bc5637c3-5e09-b01f-8b9d-f7dcb3b578e1@analog.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <ab7bece4-ff89-3889-615c-7b0b085c3e03@axentia.se>
Date: Sat, 19 May 2018 23:55:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <bc5637c3-5e09-b01f-8b9d-f7dcb3b578e1@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR02CA0098.eurprd02.prod.outlook.com
 (2603:10a6:7:29::27) To AM4PR0202MB2770.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;3:+v+WvAKL13KEsjxIdJGr3791tlRPnSxGcF/OFTRTru7JSctu3rFQ/GAQYV7h37lQaVUJePNjI6uFI7u//K11Hsj8lrB2UTLsb0CU3Sw71132rO4yoAgrrS8qWCNEfkmr5fjnCBoH/Y76chPu/H1DZmh7xkr0kNnGkuny0/qVI2HJj3wnXIpOVaOlTB30fBjjR1DXv8joResrpDUST3jbxBMNrkRlUYvfN1a1oIZukzaGRm+pw5eUR7LikjkHPT61;25:FMgySAnVY+fApu8K5FUJAAztgOVII0u2jC3HTYn4uX4oZ+vzsc9AsNv7dIXLhDo8qovz275Z2PSDhqGYZ87W6l8cZcGR04KuKazwYf242yvFQIYBjJ0TaRVH7szBku7jDW/9dbI1iFkDFS8aXKEMTdf2xM+Fkg5uc1XY0g3eHV+gas0nf7JV1rYckMWRQ8TwcdijCFjQdBdMKVSPUjihUnqb9Ba57rFzTmGZX35ZC3KBnJFjHVANMa9TzeCIfTZ2K2JlPVF8yFuXUry3V0qaZkDchsiRHMw3QAaO6DiOqXK4BmOR1z7hYUq8in+fiUQAldw8RxxATocBe1vdCRLurQ==;31:7Zh/kd/4NA2POQcInPoqBJgtaToYwZP1GJxB8UsG46YsagQuKuSiYMHHBOuxqbgCzRdSMur+k4j8p0i9ErWKBx3q+Oxl8eRlmEOhWMbZ8O/Mg1BgSbwsMORnoN6fuTBUxIsOTOhjqZdQsPqrRuawS0VGr+345FCuWB5s4s3QbmF+NqTjzIy75usA/mRdbH7rA1rcAz5a74ttBaepRQI4pRvhqplk0X0GldyA7NzBaes=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2770:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB277051651F46301398523095BC970@AM4PR0202MB2770.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:AM4PR0202MB2770;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;4:oD6+9oDZDX5DOpTH3MS+SbXkch4rE/0KAAMKrlb++B8ijqHKOIOu0vBBQQ+Q3CbSyRzSLTof0JDkmekM4R4Bo7ztVEd+yCefRvC25zl9rJnZgK1wHK9eb8yhBaWZdfGifqdhO3wTzEziq4UIpSA/BlrUmaxLyYc3bO545i2Jafn6KlQQwGJgmSJZU5QiFlQw7Ge0l4C85hICq8Ev8+9JUoLNYy/S0ON6cAu58OgVGoGiFayStDX5jcy4ohtZn34yLbxedrtwpZ55ID6iA7+9D2kgb27fmvnDEeNWSogy/yawZJnjEZxyBlJMXjJ01a3p
X-Forefront-PRVS: 0677FFABBF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(39380400002)(396003)(376002)(346002)(366004)(377424004)(189003)(199004)(316002)(478600001)(58126008)(54906003)(305945005)(16576012)(66066001)(7736002)(74482002)(50466002)(86362001)(575784001)(68736007)(65826007)(31696002)(5660300001)(47776003)(486006)(97736004)(3260700006)(25786009)(117156002)(8666007)(386003)(53546011)(476003)(2616005)(2906002)(229853002)(31686004)(53936002)(6246003)(52146003)(36916002)(23676004)(52116002)(76176011)(956004)(4326008)(11346002)(2486003)(446003)(6666003)(106356001)(105586002)(65806001)(64126003)(81156014)(8936002)(81166006)(8676002)(77096007)(26005)(186003)(6486002)(230700001)(6116002)(16526019)(65956001)(3846002)(36756003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2770;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzA7MjM6QStka2tsTS9RTEVsY0dHMUk3dWx1SFZx?=
 =?utf-8?B?S0hsSWszSG9GMHVCR1pLUjRrVWNmcDZIeGQxMkE5SHBmYXAxQk5OaUIyYkFX?=
 =?utf-8?B?eXhyMXozaGk5ekxpam8vV2RYV1FjUk5XU3FCTHlpTFFKL3U2aGVHU1dRUDh3?=
 =?utf-8?B?TDNXQktjMC9iZk90QkNYaVdIMXJCeDVPbzNiZUExdVllOVhyaExTQmpET3l5?=
 =?utf-8?B?ek5scVhld2t6TWR4bW9rNXRPeEtIZDdHcUZXcHEwdDZXeHNGK1FpLzAvZUVq?=
 =?utf-8?B?ZDlMWi9vK3lwdFdyNzRrL3V1RmNUS3V6d2VVNlJ3MUp0aC9kbk5UcU9PZnJj?=
 =?utf-8?B?eWd3VUJLdUl6RzZZckszQjNzQ1BJWDgzV1BWU01uR2FCdEhoN0twUFRNZEdp?=
 =?utf-8?B?QkdieGVCUHlwckt3T2JOM1VMcjNYZTVhMndWYnBSYnVKUDBncFhJMkxuZHZu?=
 =?utf-8?B?dTBvNklXelc0UHBZenkxaVpwZVUwVXdDSlhJdjgxYlBhalV1OHk1Uzd3dHpS?=
 =?utf-8?B?and2bk5reTFYQzRGOXlBbnplaVZIQnJZSHBrY0dMNGlNR0gyUlRlNzcrR3pO?=
 =?utf-8?B?a0MraUNjem1sb21mMjJZYWtYZ0NIQ3JtZnRLb2tuemIyWkFHMS9JbTA3czJo?=
 =?utf-8?B?aytmcEppQTY1USsxRmdKL3NkQitiYWI3TTdURmtDMWhmOEhqQ2dDU2xYMlp4?=
 =?utf-8?B?SjR3Si93WVNZWU0wM3U1cmQrbmE3SExYMXdVOEVWYmJNUEFLZGwwenBQelkv?=
 =?utf-8?B?RGNmQ3hTUmQxekdjMTlpVk1IeXhySVpLd2dXcWZvMWxEc2IvcHNPVVc1eFF2?=
 =?utf-8?B?NzlNenBkYzhOTXg2WWdWY2NOZEZzVUZJVjBlOUN3R3NxcmJ6WlpEOFk1d3Y1?=
 =?utf-8?B?UDA2eFNNSktJUVR4SW9HYTByYW82bHBIS09MbGJQcUNON1VqOGo3UnAzRWU4?=
 =?utf-8?B?ZkdkR1poTVkwc2tVSjNwSDFMakhXVXpPbGVoV1RYbUwvN0JFdlFXek16RHVu?=
 =?utf-8?B?ZTE2MHY2UWw1cWp1MFhaVEk3N2VTV054TjV5V1dpTHg0L0grMW9RWGFsUE5x?=
 =?utf-8?B?SDZkOFNLZmowdWZFVm5IUmZ2TVpUNmZBV2NscjgybGMxRk15MkhBd3A3Y294?=
 =?utf-8?B?UitWVzN2QnNjMVBMQkhZYTJaM1luMUJhUGdDSDRvM1BYQW4xQVNYT3EyVWdX?=
 =?utf-8?B?WWZPalZjSG9STHJNYklEV1hDL0RVR0JNeXQ1TWcvekwrS1J1U2orUWV1ZWFG?=
 =?utf-8?B?aG0wM3VLdjk4d3RQUmpsTFNCTEVtTUEvLzQ5SnBVQldqRkF6UC9RLzJiTWls?=
 =?utf-8?B?bFBEUy9KcDE0c2tlajVIS3F4VnJJOENETWxlTERWRU5XclRIN2ZITlhwK0lx?=
 =?utf-8?B?K2MyNEdWWEsvaElXUWJBSDF2cjlDV1VxTlhkZGVCM0NaVk8wR1RzMUZxUU9a?=
 =?utf-8?B?VzhIOVhVVVFvZDJ2ZUl3N3lCWXZhcWVmbXpiK3NNc0M4bGtWWEFUZnVrWGpL?=
 =?utf-8?B?RTVPNmNXMUJUUlJGUkRaaXhvUWNhRisyZURVYzFJVVd3OUp2cUxrT3V3cnRD?=
 =?utf-8?B?QkRkSzFFUndqQTJrVXJKTUp6Nmt5MUU1MlRDVERJZEs5cFdvUTBnaUJiNGNY?=
 =?utf-8?B?SmdPcldHUFAvNmJaRnBmNmFmNjB6ckhLM0VTTnB2L2djS1ZndmdOWndKaTZv?=
 =?utf-8?B?dkJoRnBmMUludzFjM0ZRRHdpYjQ2cG5TbFNKV3N3MGFUbThUU2xiWDhhbm1D?=
 =?utf-8?B?RUUxL3dJNWNJQk1paVdONElvZEpqVVFOSXlOV3NmZHhwRFVPVy83N21nUWV1?=
 =?utf-8?B?RHcxcUN4LzBKamVCK09WOVJaSVorY3d4L2t2VVlWVXU5YmpwNk0vZ21tOXVH?=
 =?utf-8?B?YTlsVjI0K3RrclZrWVlneVM3M3RudHNZUnlySzg5VGxhbGRFdWVhUTRWa1dv?=
 =?utf-8?B?SUNsdVZIc0xXNTBYdEtWRlN5QmZNK2M4MWRYMndPSTFpWkJWR21GWmk3azNa?=
 =?utf-8?B?U0FZK0tUaXl0Nm1sUTJ6U1pxUElWeS9PMjVSNzFIRm5HSXpMMWFTTjIrQkVh?=
 =?utf-8?B?U3NWcDlVeHFTN1VvUGxoWTNGd0ZuSi9sdHBJK0w1YWFjS2M4RDBoSFN0cW5a?=
 =?utf-8?B?Mm4ybHJRV0ZCKzdZakFneVE1QXZGdVNHLzlVVjkvNWZRUGRLbnV4VTJFVERx?=
 =?utf-8?B?aW16cTVZbzV6QU8wcmRXNnFUamFCTlE9PQ==?=
X-Microsoft-Antispam-Message-Info: UdCbIoKqsAx9V5giwL5CIlYH1p6kKHGI+BEECOI0D3eZogG3jNS9M6pDlVelZ+5w2vMl5DopJvApYNJR+AIfoCWLb7frhUGeoAO3RYpKTKT8OlsmoQwAzX2eRLKL5TwRCM443uK4fKrpY1nKjI7xpgUAzqv+e/455F9Wbe1w1nwhLjLIyWcmHPIvQImehBmq
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;6:/hhr1Q4s7dNEjPZvreB+C/QaLrIuKfcV+hpJssjHU2E2XSHT0m+V2rIqjdZrNRKtZ1RBC4ZF4WKtORIvaedbkmOGH6IeCscgTMtx4yBVBbqarRlTGFLtzCaRj5/B47wesswrZyu/mGr+Bl4U/BaCDo5lK0y7zqd05q6YxwsHsVcR/dMQmCRSdHTfRBVVortBLNIXefcT3OEeRzklXNRGo//zqJPYLn3RIzen2WuNMxFTsBHjwZiKZ5xVMeQ+DmVRUHM+IiKkjHKYyhYk8oa93QvCbUw6NRV7PteAD7RSh3cOW6jue4Fby+avJoDshZpNCG4Zcuv/fhjZ5wUr2yAFz7ByJe+TI6wfIo1iqrhG1nTsuQm36gC/tgVcOg06nqi5iOwXLLvMZ5aLLf8BwFCCbVzrHaZaAeU1TAbGZ7m/O6y/5vDljvhHaStNh8iKH1andJueVl7V6RTYjFhJeIbaDg==;5:OKs+jVWHgtpmXItGgyDuwaBNlCtQm6DBgDsmZbli52bBhd5AKug2QWhvz6u9aQM9um1Z7CcayRI4s+DTmPp9Ebfltk+DS/5PSuIg/lHf5kRIf48zTIlaHbA4ofICLL6cRpFE4kyD7FQdrAj2IOSuSO+CJA06tqnYDYv3pBzhYWQ=;24:+s1gELeTRwiZdAC5PGX7gDWw4x5xvaIYNIrltSjvOB+pgCuMR494/C93T4yo8mRiG6iEMWeP/zMFI6PGzE+2jlFU56v6Tf5JuKBAh2Jrw9g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;7:AX5tYnC9yv1h89q+rKOrs7ypmyZX61Q3N+5lBjsfI5y703BKUutZm1lnABQgNDo47H31wCvlL3T0D0Ieyj9RU87+VkjJNyB/2DIz/Kxt674y0RbIB9n5ZTxKuNw6PHiP6UmqrwcYrntjliP/JgzIBB7PDUjw8lHvFJsoL8JLIY1zP/D2Yp4e6Rk1ZjysxKIOqSc93vh/KF+iFAL1Pz3RfMJnN63MkQhzzzDGFUe9F7//3FbkRZBnib/2UHvr58xD
X-MS-Office365-Filtering-Correlation-Id: 2226989e-ffd9-4985-1bfb-08d5bdd3511e
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2018 21:56:02.4197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2226989e-ffd9-4985-1bfb-08d5bdd3511e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2770
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-18 11:26, Michael Hennerich wrote:
> On 17.04.2018 16:32, Peter Rosin wrote:
>> Use the new probe style for i2c drivers.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> Thanks Peter,
> 
> Don't know why i2c needs a new probe style to save one function parameter...
> But this patch looks otherwise good to me.
> 
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>

Thanks, added this patch to i2c-mux/for-next

Cheers,
Peter

>> ---
>>   drivers/i2c/muxes/i2c-mux-ltc4306.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/muxes/i2c-mux-ltc4306.c b/drivers/i2c/muxes/i2c-mux-ltc4306.c
>> index 311b1cced0c0..a9af93259b19 100644
>> --- a/drivers/i2c/muxes/i2c-mux-ltc4306.c
>> +++ b/drivers/i2c/muxes/i2c-mux-ltc4306.c
>> @@ -206,8 +206,7 @@ static const struct of_device_id ltc4306_of_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, ltc4306_of_match);
>>   
>> -static int ltc4306_probe(struct i2c_client *client,
>> -			 const struct i2c_device_id *id)
>> +static int ltc4306_probe(struct i2c_client *client)
>>   {
>>   	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
>>   	const struct chip_desc *chip;
>> @@ -221,7 +220,7 @@ static int ltc4306_probe(struct i2c_client *client,
>>   	chip = of_device_get_match_data(&client->dev);
>>   
>>   	if (!chip)
>> -		chip = &chips[id->driver_data];
>> +		chip = &chips[i2c_match_id(ltc4306_id, client)->driver_data];
>>   
>>   	idle_disc = device_property_read_bool(&client->dev,
>>   					      "i2c-mux-idle-disconnect");
>> @@ -310,7 +309,7 @@ static struct i2c_driver ltc4306_driver = {
>>   		.name	= "ltc4306",
>>   		.of_match_table = of_match_ptr(ltc4306_of_match),
>>   	},
>> -	.probe		= ltc4306_probe,
>> +	.probe_new	= ltc4306_probe,
>>   	.remove		= ltc4306_remove,
>>   	.id_table	= ltc4306_id,
>>   };
>>
> 
> 
