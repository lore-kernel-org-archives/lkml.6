Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbeDLIc6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 04:32:58 -0400
Received: from mail-he1eur01on0069.outbound.protection.outlook.com ([104.47.0.69]:45824
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751112AbeDLIc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 04:32:56 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=talgi@mellanox.com;
Subject: Re: net_dim() may use uninitialized data
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAMuHMdWovmqqgrOvtA=cyineJigwOtv-tGwz_PBVRFrgtryumw@mail.gmail.com>
From: Tal Gilboa <talgi@mellanox.com>
Message-ID: <a90cf5d4-f744-8b4f-4d3c-36ddd5842aaa@mellanox.com>
Date: Thu, 12 Apr 2018 11:32:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWovmqqgrOvtA=cyineJigwOtv-tGwz_PBVRFrgtryumw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: CWLP265CA0205.GBRP265.PROD.OUTLOOK.COM (20.176.52.153) To
 VI1PR0501MB2607.eurprd05.prod.outlook.com (10.168.137.19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2607;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2607;3:jmjcGgX56v+4YiTh30Sf+ymwHQgdT8bIRVvDiVcNlOLN/CrLt7BnjVnxuzEKxmqNQtCscaC0K0eGvJn/r1CZPl2MR23NkJVaJNNG1mpl4MObrYg4ic59YB7s9VIrvSUCoTINRVzTXuy44TP/19yDv4ae7333rvSYGl8M7CkXX8wDIBMC26V63tsZaAZ5rnaG9GCmy7aD6is9LMTYxvlzLrlfcUOHk68/HvNIgx70h56rZLCOXmOEqCUKm4n+tT0c;25:zxAQu/GtajjOqBlr5YxS5dq6e2GSXlXXmvYgAtFsRA3Jt6gRtr3TZvfcfKqJRriahu6N8LlgB6yAuEntvCU5Mdb1Qe5OeSrZhvyi19bVYIKUYrY1/HwdpZ2GeFLPPqa3dbuUj8dLOZc5UrCHMzxg7vLUDZPxAIzbPw0wrSEFkFYbxSTbdbWvR4ua5/Zshp5RuZGk/QmRUZBk6BWc18W2EadCsmCZxdcK1NAy/w2W7N6LSF/SoyWxRMnPcXwTbnHXWXIexHSsZ8OQR0h7KrODd5USDbLAT8ftCUVl1+/piHEo6GU95Itf9O+xPOm9FxxVoTgCfhgVd7CdQD8TjYuDvQ==;31:Th2Bif+V7xRu9A7GbyjORMxg2rz6TxIRJcIhQL6UmXzCsM2hUnzzEQlGU5qHPhLQ6+erS2UId+oDBwyU6cpOy659gNNWyWjCWI8sikoIq7M6x/1vBN5hOhTv8hR7ovUHurU9FSOG3EgDDOzsHqGoWh1veqYjF9g8QPT74doW18G2OH3IAlgyEgy0mv+RPSxHpqAsf4xBkXa+SPT9CTdQVx4KzwJpRfIrRKx5FCO4DnY=
X-MS-TrafficTypeDiagnostic: VI1PR0501MB2607:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2607;20:MbcpzVIkSLXSsJpHX2qXkT9fVlzk/c1L2nznNqDvS+b2kMwW5/bmUo8OHoZNVnEH8NBRNJ14fS2s/n16AIPaxdgO2cCIuN5MxYOdF6cRI+bv7wt4xKJyqJM0g9quNQtOL8H1XKDLYr+7rGfZhdb6xx4Rodjz3TDoptUO9NM1yAPorp8Ak9K5x9SCNlMugAwe9D5YnqgLijXDUseBf1IuGcx9ffuYjWPsztm22wOG9KZb+3bO59TP48/e2yQ0ZFdv2hOs9FF1wE7wPLwLRPJ5AK3axO3dC7UESA0RTepzTxG0HIBuMd+kni4YQg28n8jmJCuEkxG475RhRhtCXfqzG1TTp8nJNySG+302Dir+m8/dUYMa1mtqYbY8NUnJKofil/GeE9xNn81zKmF98IX+T7dLLUOFDLUun+rdTx2fApBmTm2o4lsttfGRkQTLeh7GH1JS3x+3lBiUfku18fkEcGvfLoeOI39wr6wsifwMhOY5JORbBkALJeklQsg+JFFB;4:fZRxhQAXJhTbjIEBGyHA+LIsjkcJiXemDKp/8ONeZ5XaPw5bZ6d89yJkyil0uPqGT7O1VGogKtlbVoTcZnXl7/AzY2gRomTVSxN8RcymY2I9x09z8iabzzLqUxe6PEzuY2yXmlgMc5MYzjtdqGSoXP2WXiJDljOjiY9nzJvvXoH9LVveQxCi6qZbXCFH7s8D/WBN2CfVwoPAcat4sJOtwyUTtuOH/xSFpM2Yui28Pnj/yVHaRvIp10Pmh9y7Xpd+4V6S2Ho+0rxiyO4RQovRbQ==
X-Microsoft-Antispam-PRVS: <VI1PR0501MB26079F36762CB445707BCA4FD2BC0@VI1PR0501MB2607.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR0501MB2607;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2607;
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(396003)(39380400002)(376002)(346002)(366004)(189003)(199004)(23676004)(52146003)(2486003)(76176011)(52116002)(67846002)(53936002)(6246003)(25786009)(16526019)(4326008)(77096007)(186003)(58126008)(105586002)(478600001)(106356001)(3260700006)(54906003)(86362001)(5660300001)(7736002)(305945005)(36756003)(8676002)(476003)(47776003)(65956001)(486006)(66066001)(65826007)(81166006)(81156014)(65806001)(97736004)(2906002)(26005)(229853002)(6916009)(2870700001)(31696002)(6666003)(446003)(8936002)(68736007)(11346002)(956004)(59450400001)(2616005)(386003)(64126003)(53546011)(316002)(50466002)(16576012)(31686004)(6486002)(90366009)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2607;H:[10.207.0.54];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA1MDFNQjI2MDc7MjM6dXRwVnRQdVdOdnBOc0dhSVM3MEdTSVJr?=
 =?utf-8?B?d0RJaCszc2hRZ25UNGhPM2pJWnJBdlo3czhlUGZVVzMzUXU0RzliYjFDcUsy?=
 =?utf-8?B?dXZwU1NEV2JrRlMvUDdzc0NSZy80Q3J1R09VZm9PWWVIdzNham5veTE4ZjBu?=
 =?utf-8?B?K0VWNkwxSkJSUUxJc01YVnJHaWZydngrZElsVDJaUGErMUZ4RVNXQUdtSmd4?=
 =?utf-8?B?WCtzQmR5QVhEMnltNFZVWUtDQUJnRjBVWHN4Y2Ztb3kvKzM1RjZQeWoxRkFS?=
 =?utf-8?B?SDBJL2VWZTlrdlpzZ0c3c1VkZC82a1VpSnlVOWV1cVRCR2FXakgvTTQxYU9J?=
 =?utf-8?B?WEt1NmEzSndiMElROVZVUFk0OFJ1SG0wTU9LdytGazJtS2ZNN1hxSnREMWJt?=
 =?utf-8?B?OUYwUFlpVnl4dWl0WnR1U0E0M3pGQ3lpMlFONkF6UzFGczhhQlk2V3BuZWZm?=
 =?utf-8?B?MWUyRkxETERSb3FocDFvcEt5aFlxallqd0V3SWFzeDdNZTFldXo1eUUzeVJG?=
 =?utf-8?B?WUwydCs1M09md3Vnc0RhMVdvZmlONVpNMFZBWVJzRmdYR0R4aFNRK1BVRkNR?=
 =?utf-8?B?MXovVEZGdWo5U1VqZkFaVmVUVkQxc1JDK0Fjem9ONG9YRHlkWG5mY2lQZk16?=
 =?utf-8?B?ejFCNDZVL2E3K2g3SVE2SCtuVG1PdU1ReUxOV0tRYzlSSjJwaDZCWTVlY1ZB?=
 =?utf-8?B?RGl5Mkg3emgzTTR1M1l5QUxUOGgzWU1FL1ZjV0F2MGJTRVloeG1Raml2cW5s?=
 =?utf-8?B?NDdNN1VJanJtKzV2MFZ5ajRoNmc4STk0RFRqSVNmQzJVVHU2VGFLRmY2MGFT?=
 =?utf-8?B?b3FEanZCamxLQ2VPbGp2c1BEZS9ob1JhVTNjMkgyWGl6Zm9mbGphb1ZZTk4w?=
 =?utf-8?B?Nk5BVHpLeFpHKzVzVHZEWjJKamY4QTZtc1NwbkFTMXZEa2tmUkF2RzNGMEha?=
 =?utf-8?B?UEo2d2owR1Z6Tng2aCtYT1VQRlhmWW81TXZkeTcrQURGb1VFU04xOStWMWdz?=
 =?utf-8?B?blZrY1NNWktmNTZLZyt2SHYweU9tbHFFQmtpVzQ1ODN1VjF6WXd5R1dMeEJ6?=
 =?utf-8?B?NVllSi9XZUpqeDVTMDdBRzJWK1dqSVJVRFNUWlZpNnBWc2R5c2gyNUNNQ2dw?=
 =?utf-8?B?eVluV09qSjFXQnNaTXF3bGlSdUpiWXMwMU85a3diOHl0QmREVFN1WWFhZVlK?=
 =?utf-8?B?YnQ3QnA2ZkM2WkgrS0xDa0dPLzEvaWU4amUyMU44SEtDdkFlb1ZMWUJ5NHVv?=
 =?utf-8?B?NmpKK1BheVhqWXdUR0xNUDBhSklyYzlhdXVsRGZNbVFvVWRkOVdway9SMkxT?=
 =?utf-8?B?cFhHWEsrSlV3bWdQTERnT0U0NjVhMGFieW12WlhhRDgxSG1iN3JCZjI2U3V1?=
 =?utf-8?B?K2NBWlYxZUh3a3h5U2RUc2hPaHFYUXFYVDlaK1R2MXB1RUhjdGxjWmNFbEFT?=
 =?utf-8?B?YW56OC9NM0lzanppVDJLczQ3c2JZVWVQTG9rN05UTDhSL2VzOWRORzFHdTE1?=
 =?utf-8?B?NitGdTMzZ1FyTjd1WXc4TWI4aDJkaDR2UHVzNTBkby9PV28yaGhpNitNSUN3?=
 =?utf-8?B?Y0RWSzZvMjA5SXEyeGN0VU8wUmdQNmx1dVg0Ri9WemlHS0JQMC95SmZUSzhh?=
 =?utf-8?B?T2oxYmJJbWtveWh6UTZZSE5UQll2aUZZY21uOVRQWEZWS2RnK1JVU0pxMlha?=
 =?utf-8?B?WUJ1Y1hoOUJvTHFQaEtBb2xsTGRrVHRxeFhKbG5iR3ZwWnI1SFVjbVVCL0Jq?=
 =?utf-8?B?ZUNlNkFhMm9aMERsNTRPUzY5MnA2eG1zOVZ0V2M5NDlTWjluQWQyanRyb1Q0?=
 =?utf-8?B?VFh5ellQNnFXRE55TU8xRUx0cFV1ZGR1eXJoblkvZGdoMEFiR1hYOSs2TS9T?=
 =?utf-8?B?d0FKN0t6M25qclhIQ2RVUStQZVJJR1NzV09aNUxnYjVIUUR0TlI0TnVTSUVR?=
 =?utf-8?B?d3RWV1JhTFVNdCtHZ1dkMFJwc1FSdUpkdXFGSGJXdHVRbWo0NWQzS1grTWNY?=
 =?utf-8?B?bkZ2N3N0VmhxOWtweDR2VzZ5ZDErU2Fjc1RvSWY1YUtMMnZCaDdzNmFWbWta?=
 =?utf-8?Q?+YZnBL20Fy3ptGa00ZFdrHk8yA7?=
X-Microsoft-Antispam-Message-Info: laZRGzqHfAqYFLKA+OCJZIDujQRXnxIvbM30SFNkw7yg18zCwce6zV+TfBYmFp34RPXCftyXIGaHBnCNHb4rcYfwGpjPZEqHz58+aUWh2IxOVAQY9y84pkAW4gIPxVq8SsO62iG6u3RlDK2YFRasO1ueowmD0eT6jSdZDQSQtNJCaYE6/UPmFysVYyYV5mYm
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2607;6:H7GPLzC5v6tErl6ICgvOsEICs9C1ZPChnIYv4x7yELccWkfGPdE2234HYDTNPYXZP41sztNgKysTlxOk2oLpdZ4KoKKaUeFdbbsF/7u66gxfObCx0oK3oDsA2O+Oz62rkwMNYn3+W/343thACZFVDiSkh+jlZqU8t//FP0ETI16kGyo1+S33dVZINCDBZgKKzKF+6/N9vev014tdGo1hchopQaWAXBzfC92RIrI6DTYgVACdqkPi42k4sIG/n+0MOdhQwVwWcyrxYnE6b7wRIQtbnwZ5+7aM70ai4N1edP9qj+SYTvBaDn/N18RXRfZL+v+zrm1MF+nxMvZbJMHVtRwgIUqeZZvIKP5P6772MSP+qlgO7Jt/9mOioGbMwqJBXflQOrD9dUgarY8UJRyrJI+/pbu4XTcbr+AcECZZXVIEDSY+8RK/I5WsGbFmGPngeq8eIx1iFvX68NsPXm78Mg==;5:jz/081gXBMYhXloPNEYJTQrlu/3ud/aExnIZ4OQN+t/DTJF9tgBzexSR3JK2xXy/152NMILkLjKcHlbd16sda5XbNV7yK3LxsFG+iNscOb+Mvh2Fs6sQvqq3pmZOKnci4i4ZYQhEX8yopzoqDgErUm6MbLU0B56v/yta7qrgi/8=;24:+oTUR6/oxs0gWocaGWXgSmdU4aBSYiW8fVPhLSZNiIOtEM/KOOu/cuh1s9hVuyUtHlgo5E4fdwT22GyRdFrwZV4es9nF4XNVkOroJhbJVog=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2607;7:th8wAnWE6VgQklpgGplSXbEoQc+xRwJL38HYRG9CzAM6Q+GYLXCCLavwYwDmJy2htG3/RlppAdC5PdU00v7amB77iUrGIgplD2lig7eV/utT4UUbaCSA+qV3mlsBX7Aq7DKxPEV27VVACLiP5LLTq5TLLr99ZUQJlMZGbvQQH5WGftSilR7BX94mTRKFnFHx+p98wk/5U1mvN5rbqjmAlrS1zuhocuvnfkMEwUVsRI9v/7v6DLkNoBfxxc87+qC1
X-MS-Office365-Filtering-Correlation-Id: 89e477be-e970-4dd7-9bab-08d5a04ffbf5
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 08:32:52.7831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e477be-e970-4dd7-9bab-08d5a04ffbf5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2607
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/2018 4:13 PM, Geert Uytterhoeven wrote:
> Hi Tal,
> 
> With gcc-4.1.2:
> 
>      drivers/net/ethernet/broadcom/bcmsysport.c: In function ‘bcm_sysport_poll’:
>      include/linux/net_dim.h:354: warning: ‘curr_stats.ppms’ may be
> used uninitialized in this function
>      include/linux/net_dim.h:354: warning: ‘curr_stats.bpms’ may be
> used uninitialized in this function
>      include/linux/net_dim.h:354: warning: ‘curr_stats.epms’ may be
> used uninitialized in this function
> 
> Indeed, ...
> 
> | static inline void net_dim_calc_stats(struct net_dim_sample *start,
> |                                       struct net_dim_sample *end,
> |                                       struct net_dim_stats *curr_stats)
> | {
> |         /* u32 holds up to 71 minutes, should be enough */
> |         u32 delta_us = ktime_us_delta(end->time, start->time);
> |         u32 npkts = BIT_GAP(BITS_PER_TYPE(u32), end->pkt_ctr, start->pkt_ctr);
> |         u32 nbytes = BIT_GAP(BITS_PER_TYPE(u32), end->byte_ctr,
> |                              start->byte_ctr);
> |
> |         if (!delta_us)
> |                 return;
> 
> ... if delta_us is zero, none of the below will be initialized ...
> 
> |         curr_stats->ppms = DIV_ROUND_UP(npkts * USEC_PER_MSEC, delta_us);
> |         curr_stats->bpms = DIV_ROUND_UP(nbytes * USEC_PER_MSEC, delta_us);
> |         curr_stats->epms = DIV_ROUND_UP(NET_DIM_NEVENTS * USEC_PER_MSEC,
> |                                         delta_us);
> | }
> |
> | static inline void net_dim(struct net_dim *dim,
> |                            struct net_dim_sample end_sample)
> | {
> |         struct net_dim_stats curr_stats;
> |         u16 nevents;
> |
> |         switch (dim->state) {
> |         case NET_DIM_MEASURE_IN_PROGRESS:
> |                 nevents = BIT_GAP(BITS_PER_TYPE(u16),
> |                                   end_sample.event_ctr,
> |                                   dim->start_sample.event_ctr);
> |                 if (nevents < NET_DIM_NEVENTS)
> |                         break;
> |                 net_dim_calc_stats(&dim->start_sample, &end_sample,
> |                                    &curr_stats);
> 
> ... in the output parameter curr_stats ...
> 
> |                 if (net_dim_decision(&curr_stats, dim)) {
> 
> ... and net_dim_decision will make some funky decisions based on
> uninitialized data.
> 
> What are the proper values to initialize curr_stats with?
> Alternatively, perhaps the call to net_dim_decision() should be made
> dependent on delta_us being non-zero?

First, thanks a lot for pointing this out. There are no valid values for 
initializing curr_stats. If we consider the most straightforward (all 
0s) this may result in a (big) negative delta between current and 
previous stats and a wrong decision. Any other value would make very 
little sense.
The case of !delta_us is an error flow (0 time passed or more probably 
issues when setting start and/or end times). I suggest adding a return 
value to net_dim_calc_stats() and abort the net_dim cycle if an error 
occurs.

> 
> |                         dim->state = NET_DIM_APPLY_NEW_PROFILE;
> |                         schedule_work(&dim->work);
> |                         break;
> |                 }
> |                 /* fall through */
> |         case NET_DIM_START_MEASURE:
> |                 dim->state = NET_DIM_MEASURE_IN_PROGRESS;
> |                 break;
> |         case NET_DIM_APPLY_NEW_PROFILE:
> |                 break;
> |         }
> | }
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
