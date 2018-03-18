Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753316AbeCRH2k (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 03:28:40 -0400
Received: from mail-ve1eur01on0063.outbound.protection.outlook.com ([104.47.1.63]:30976
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751003AbeCRH2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 03:28:37 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com;
Subject: Re: [PATCH] IB/mlx5: Set the default active rate and width to QDR and
 4X
To: Hal Rosenstock <hal@dev.mellanox.co.il>,
        Honggang LI <honli@redhat.com>, dledford@redhat.com, jgg@ziepe.ca,
        matanb@mellanox.com, leonro@mellanox.com, linux-rdma@vger.kernel.org
References: <20180316023713.30323-1-honli@redhat.com>
 <ec18ffec-d7af-9a52-2da3-d4abea23e1a0@dev.mellanox.co.il>
Cc: linux-kernel@vger.kernel.org
From: Noa Osherovich <noaos@mellanox.com>
Message-ID: <b8a36b58-8791-97c1-cea6-de36981b83fb@mellanox.com>
Date: Sun, 18 Mar 2018 09:28:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <ec18ffec-d7af-9a52-2da3-d4abea23e1a0@dev.mellanox.co.il>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: CWLP265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:11::21) To AM2PR05MB1060.eurprd05.prod.outlook.com
 (2a01:111:e400:8438::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d3ddf837-4cba-4af8-d65e-08d58ca1dad4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM2PR05MB1060;
X-Microsoft-Exchange-Diagnostics: 1;AM2PR05MB1060;3:7zYNphBsVK6A8+DwRkBioq/APYYSMc6PWfL9CiecxVFPiu4mqcwRTMTuU/myurGzuhLlS3WD8xPPbtlcs9wepGkthJwXD0LERQo2aU9/HNTxJTA+Xv8bBSKFvAB5FZMDA+8Fe9Tx9nSTEZlrQqz2awAKdmtqRujMsG3Mxp/WctD9A+YuCv3nu0yP+n8XnaTzQmQB8JEVm+EpQw4zcqLTUlKy7ZwFgOIiPoolKs5KCcaxgPQzBkHbE7j4ckgNti6n;25:5W7/DeiamGlVUzq/DQOxW5vKSB5y0RTik/lhIMs0OA76muQkksaQ9wMjU0emBwDvDMdbEa9iqRDbySj3xWeuTpD4lxQZQfOKwOlsIzKkgu6XFnhKKpZK3x/MRFfyr6F8z8juejruiJknpuqxwfWfbTTWbdLd+mIMuvup9stHk8htu7Kevv0Q+RUbg6AvllFuk5bz40U/3RXuGIb75RJZOtrpO3DjLrHJ2ZRcI06044wgX2XpnMwj+3Kt/Nzfc7kTkXlDi838/VBgASl6c70Mh2gO8TjfP0qthKwJPGgGT6vhssHjhzMAaU0ZrMOTFcFYixrLc6j2/lgg6urOUKqjQg==;31:lLI+KFRNu5Bzc2D407drcJnt6DA2O4TLjd91tTdbSpljy6K3KILcsPgvkOamCElB0tXJjY4RenfE9FJRg2xdrv2JV+e/bZFzJK0EfeiTtQolQvuJP7oDF9LqQHERRClfEv1Aj8+xL1sQn6b+Q8EB/dYmWhdPlicJDCPWhXhhK50GxzOW25DO94eN844MoKPaJOTucB6pYgAtjhHry3CKlSI8KS++8PgKfkXbmQA1tzM=
X-MS-TrafficTypeDiagnostic: AM2PR05MB1060:
X-Microsoft-Exchange-Diagnostics: 1;AM2PR05MB1060;20:LvW7Y5kOkZLNvs94UO6L5XTFnfRjWa0yMmh6j3qvSavBDbXnPpk7n0roN8bG71YKzH/xmMaShilQVcmrWaHUyEER9hAbA6uVEiY+qZjVBM04oj3e8TjnA45dJBoTRHSO3CRilyCQUdbTiQ7WTYKGigZ0WLBnBPk7lZMtlWtDrVGMGFkOJW/F+KRR4MwrVLHgC/+4V9cwVGVZiU6iV3w8VzBcvT9AJDegzu1qX//EHFo4ZFjbtmyGM8lSIBbfKLWKIXGN/ucOuGqbty3yECzISgssJZND5vTLY8t+dg+sbZ8gGPqSD3k8g6hMhSI0zI2rTSKGIHi70RNk/MoYOdq8FK8Ysv1zRTDJd0echrjJupHutno4fbf0NLc9d7Dr/848ycZcGqFCaPbyC/lBkVLslfu5kr6U42isJwGO0hvetmTIFjKngAbDNJjQNY9DryPTp1XubrRe8QPUz3Yjxazcce1YNqnuN2FSymMa9+vTyrr6EikUHBHEDt8hBgoLnjoB;4:rU+8punLfuKdBcQPexIONLtEgDr5Dz9JOpguTbIB0BE5mKo6yt3gsQA1b5ACmLQHMr3A59IR5JQ65Cb6y9CN2y1i5aESJdU2PJyCnugZF9rIZlphcGoirs0N/AxGBnnksQM9WLyYTNKBDBRGhYs0XlMhDwIL5W62a3yJzEPSP0NiauJM9H8KgMOdXn+S26Wdp3oFPXcUI1l4LiLro64FJenAYCQeyk38b2ITr6Qj/9JKgGkjdWYAS3xTHGux/ju01drwzoiusxuYeQ3LK5bRKw==
X-Microsoft-Antispam-PRVS: <AM2PR05MB106063F940A5754D6FA713A2D9D50@AM2PR05MB1060.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AM2PR05MB1060;BCL:0;PCL:0;RULEID:;SRVR:AM2PR05MB1060;
X-Forefront-PRVS: 06157D541C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(366004)(39860400002)(39380400002)(346002)(376002)(189003)(199004)(8936002)(26005)(81166006)(8676002)(2486003)(52146003)(76176011)(52116002)(31686004)(77096007)(23676004)(6486002)(230700001)(6666003)(97736004)(4326008)(2950100002)(229853002)(478600001)(81156014)(25786009)(105586002)(53546011)(106356001)(186003)(53936002)(6246003)(68736007)(65826007)(7736002)(16576012)(2906002)(3846002)(36756003)(316002)(6116002)(110136005)(47776003)(65956001)(86362001)(66066001)(65806001)(31696002)(5660300001)(305945005)(16526019)(58126008)(50466002)(386003)(64126003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR05MB1060;H:[10.8.2.85];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTJQUjA1TUIxMDYwOzIzOmQ4ekh6dUs0TEgyQ20zSkFNT2pmSmNEM3J5?=
 =?utf-8?B?cmdpSVBhcldvQjJSZGsyaFZhV3kxNUZ4SjRCTGFTTlJpT3hmYnNiSG5IZTJj?=
 =?utf-8?B?VGNrVGREWHphcStNM2RmV2pkTkh5MFZJc01sZ3FzOTJjbU00bFNDNEd0THgy?=
 =?utf-8?B?M2hwTmNhRFJEOE1kVGJZa1RMMk5ZUUhPSnRhUzJOSEtSaW94S3NqS3BVbzc4?=
 =?utf-8?B?QkRWOGpwOWZoazY4dlRKQ21YdUVnWkxiT200UUM0NnlLM1NwN254RkxrZXJp?=
 =?utf-8?B?MS9wbnNQNC84eFcxdnJERWxzWHV2RkZtKzZiWElRNzVyTll5cGlMMW9xcmcv?=
 =?utf-8?B?NGRQTG8zbHVsOEl0c1k0eDVtOEJ4eDJ5K0JsakF5S1dRMXV1eXRVNG5PUTVt?=
 =?utf-8?B?MjkrS1gzWHZGNGZsZ3Z5citZanR5YVEvQzdIOVVDa0ZiNUErcjJXS2ZUL0hl?=
 =?utf-8?B?c0dqZE9OMjU5SEJweTZRbUp6c3MvWkQ3TDM3aktFMFIyd3FuYVF6eFlES2lI?=
 =?utf-8?B?eGJqZXNWSGtraER2ZTZXaHpCUFFXMHhENWFaRnorcjROWkV6ZUtWaVFTZFNl?=
 =?utf-8?B?YXJFa2lOK3hGSDJLeW44bWFHZUI5VHdPYStUdWxUa1B0RFJFWWRkWVNuN2V4?=
 =?utf-8?B?ZTBXbGV0ZXF3U0ZFaURhM0VPeWFneVpJZjh6b3JkODA4S1RVYWduV1BLUjdz?=
 =?utf-8?B?UXJDZkZkWjBNc01BSGJqSnFEaUJDZzJMT0ViR1NUdjArUDhsNDB0YXFyVWhw?=
 =?utf-8?B?Y09hd3NGY21XRGZ3akV5eitpZEFORWJTN3FXYjBsVzFZZUJ1OWNKQWJWZm4r?=
 =?utf-8?B?dldFcXQ3WWQ4VUswV0ZWRFJldnppanBENURybjVCdnZFZUllamhwdm9GRDVJ?=
 =?utf-8?B?VllnY2FEcFBlS0NUelpIdnBmZ1BCaEJsZkRwYnhNc0F3MDZ4bVAxcTlQTzZs?=
 =?utf-8?B?VlhjMmlFQzVBZFJlemdhZjlDais3L1FiVkdiL2FWbTRJejVHZlc3U2tRWVJy?=
 =?utf-8?B?TWJ2WHU5RGt0Y2w1VjdxeHVHa1UxT0JqRGdkOHlmQmN3OFNpazZuWSswSUFK?=
 =?utf-8?B?OTdpUDlyZG5LcXBRS2s2S202T1NVSTZlYWlEQTBMeDFZQUNrbXltMjNPeUF0?=
 =?utf-8?B?NlJuWEFlaWMzSzJhNVBDSjZtVHRLaHF1UDhPQmpkNllVZTkyY1g5WXptRmpx?=
 =?utf-8?B?YXFKcy8yM3cwV3hJR3NKeXIxWmtnajFPMk4wQ1IrVjJ1am5PZ3JJOHhZOW56?=
 =?utf-8?B?MGprSWcrSEFwSW1PVllaYTJzUVNHR2V6RVhnaUE3cWkxWCtxejNINUJ6TFFq?=
 =?utf-8?B?d1NtUzRBOVY2YzBsRlZucWNQKzljVEJ4UTJ1b1VvZzd6bjBRb29TVmxGQTgz?=
 =?utf-8?B?TkxETHNWeFZsUGhJTUVLVUhkSmpOdFRpUnNVSUthTGdCb21KZWNjdTBkSnVY?=
 =?utf-8?B?RnNpYzZXYmZtV3o2ZW5lYmVkd295SEJoMkFvcUhZRkVZTDVkcCsreFRnVktw?=
 =?utf-8?B?bmFOSW0wdTY3K3U5dlIvZWczZ0JIdHFrcVM5aWtTTzRrY2o4eVBRRGpoNmFZ?=
 =?utf-8?B?TEQrWERsLzdJSjVJUjl3bkdlZXdwTVo2TkdUcmlwRHpUUEtsNUVxSXNJYmZS?=
 =?utf-8?B?KzNBa1BZZ0JHLzM4VHhSZi9zVWZDVjV2VWFqbFNUUG5ySEVHQTYweVc2Zks0?=
 =?utf-8?B?Y3dqWng1NkY2RTZ6ckVkZzVnZ0RFeVl3WlFIRWcwWEROeEp1VlgwaWh1bFY4?=
 =?utf-8?B?VmlGSnNNdnQ5b1lGT2JSbXZlRUVsUUtPd0g5S01kbzRnN0p5czNBMWJkNDJB?=
 =?utf-8?Q?ni44XixIoUTGw?=
X-Microsoft-Antispam-Message-Info: CRfgvLg2JRmD3Mfm8k34RFZxsYj7y1Ng6s8CDjO+E2mJDZ503OihfQ+BcFtIaqyU7Aak4CPrsbjez3jvkEQ4GyZbmcr8eWmCaE87X29UVxz4jSVRILpqqPjJNxw1yceSUTvGYH9O1OWuIT2YA9SSaz7vbFG+Zd1qpvf5Ra0jkL42b4dvCnh09IMWOLfmzxZ3
X-Microsoft-Exchange-Diagnostics: 1;AM2PR05MB1060;6:5/oBmqcKq6xwRUSh62WlrB8D05H8AhoMZWfkCd3JCJBCGTyV6/SoFaT+94yoM8T3BYPFcy5ZSbupjstKisYDy/epwQ2jE1tBXJZmDfEWnkmjeVRo/ZI/wKxmjsC6RID9o4994Lxg6pXHVAf6WUtvC5foZuK+jwo5ljviDe4aKPXq7L62F2bZq31rVw1i4i3PJzrTtMZ6ouRJIT9Ks3IQXPC+ZbpkGPplgGTmUG6lL8ZQJTQKw956RkH1bBMDB2AiPUwvaKY6WiudOxFjXcdqPhj4m8BHhuq6HFmqn3Jfv16cd8gGy474JW2Hs0Oa2ICkxxYxySXvE0wgGUrYNXnaSTutuctAOBpqZ9tGGs4tuFo=;5:iagFfHE3R3/D6iR8OZeb7voSlr+J6yimmeyvUFSU3M5ifGF1BTbJPnCXrY/shMIC6FRggOfXa6CWjhPUGlp34hPm8V6k7bVjq875OgD9JGnGNxsVkOKpYw4CSrNjGv2ubYOYbmtlxqzQFvcdiqx2n3084i+X2lFEVRv0+8pX6Vs=;24:iNbstCZaN8lqrkBpyugpn4zV7oSbvoNjcVEzQFDBz8IkdfsK5tcHyWOxrbjpEK8JC7LCmCDoOeMjH+mKTp4XqL7qffMfMrQTX4ExaOSDImw=;7:aLXAQL8iXPxbzdL/q+Wv9jXSe6oAe/PfmV1BWzC9KU/JF373321WsDDHtzqA/vJTkFj/vG8WLpOPxBbJWn4zx4CbMs+resLI7M7yxuP0X3uvdRiCl8jkEvGUp+nGHywLPiJDMFfvLVPvMwE2Az5ADkZZBj7dzsg0syRM+V7vPm/ajY/VgbM07IIbGNDW9Bsd5ifCP389Jeev1/sCMr5DlKt7Rb5U1Mdk1vuz9f6BthSh19L1oodOl1o4Ndh3RnC4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2018 07:28:32.3829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ddf837-4cba-4af8-d65e-08d58ca1dad4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR05MB1060
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/2018 4:59 PM, Hal Rosenstock wrote:
> On 3/15/2018 10:37 PM, Honggang LI wrote:
>> From: Honggang Li <honli@redhat.com>
>>
>> commit f1b65df5a232 ("IB/mlx5: Add support for active_width and
>> active_speed in RoCE"). Before this patch applied, the mlx5_ib
>> driver set default active_width and active_speed to IB_WIDTH_4X
>> and IB_SPEED_QDR.
>>
>> When the RoCE port is down, the RoCE port did not negotiate the
>> active width with remote side. The active width is zero. If run
>> ibstat to require the port status, ibstat will panic as it read
>> invalid width from sys file.
>>
>> This patch restores the original behavior.
>>
>> Fixes: f1b65df5a232 ("IB/mlx5: Add support for active_width and active_speed in RoCE").
>> Signed-off-by: Honggang Li <honli@redhat.com>
> Reviewed-by: Hal Rosenstock <hal@mellanox.com>

Reviewed-by: Noa Osherovich <noaos@mellanox.com>

>
>> ---
>>  drivers/infiniband/hw/mlx5/main.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
>> index 033b6af90de9..a48e9730fab8 100644
>> --- a/drivers/infiniband/hw/mlx5/main.c
>> +++ b/drivers/infiniband/hw/mlx5/main.c
>> @@ -388,6 +388,9 @@ static int mlx5_query_port_roce(struct ib_device *device, u8 port_num,
>>  	if (err)
>>  		goto out;
>>  
>> +	props->active_width     = IB_WIDTH_4X;
>> +	props->active_speed     = IB_SPEED_QDR;
>> +
>>  	translate_eth_proto_oper(eth_prot_oper, &props->active_speed,
>>  				 &props->active_width);
>>  
>>
