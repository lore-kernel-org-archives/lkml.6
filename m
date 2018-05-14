Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeENUbU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:31:20 -0400
Received: from mail-he1eur01on0110.outbound.protection.outlook.com ([104.47.0.110]:28804
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752040AbeENUbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:31:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 1/2] i2c: core-smbus: fix a potential uninitialization
 bug
To: Wolfram Sang <wsa@the-dreams.de>, Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>,
        "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1525525030-9805-1-git-send-email-wang6495@umn.edu>
 <20180510111737.b6g7s2nnf6froote@ninjato>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <ac843580-884e-b0fc-60af-8d73ba099100@axentia.se>
Date: Mon, 14 May 2018 22:31:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510111737.b6g7s2nnf6froote@ninjato>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0335.eurprd05.prod.outlook.com
 (2603:10a6:7:92::30) To DB6PR0202MB2774.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;3:Bdh4YbiTiNp0B6t/BlZGmJtwx3fHlK3fzmUqHTtGsgOV0x2kXo9foNNlNqt25bk/KrNfjMKalZ0EevoJL+ooyBbwA2wu0HorGNARkxWXXMMyj6D3acRthA8tP+JKesyOJUuDV0QQenEaOokL+JocqD0kaKCljMvy8AvMIzFIM7BlG1yRC9BYoYc9299N3lFIF/sotdMwlQ+uFiEsvW1f14VxTdjkDK66hwfbHA4YoqtNU44cJsEXZj9jtRz14Ap8;25:QvGILYInEVhv7ylYlmsk0O5dWOHEGlW+3EH2oJBjV73sIbwmmsTm5egMlXLpLs6dweU50l/NzpjkFr8uBDu051p9tDssfx2r4wznw2TRcl1ccxajlyqQeKHg7pMYbain+xt5ejOhAnaNjiuZ/ls9Pc36WuS28c8wnYDDPFBuLSo0ObQ2nkvrCpT52dB043YZKAji5KZnbOzcLjqU1u+Wm7J/X0dT2+/RAcMJgEpSspZFihdL2jaBT02BUhJgGTayuLXoCEJ6MGZr4GaXxhGa6UDvT3qatfoR4OpqeCw04HcwUk4aAiQBXG8JV2hnqxLNkdzZhR7CnqWniWn9qZyj7w==;31:itp9X7ZXZyxsQ6AKxhPD34cDUZfTaIhyACQUu27oYU+C3mQiRWEZg7dokO8P5Z10bNtINVt384oAxcDTz7BD4zOOZK9cXkY+pkOhQdiJcdYDRU0H4EjWP4N/Sb+ALM7eKWnlf7QwonvEMwfu+4nUN5O/koVm5c7xSTJsqSzt16qpeIBBpXroGOShsiO1UG9tjFn68i6DpgCF9gyElJMkLraVskA+wMNWKy3JuTaYx/4=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2774:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27746F0B07B1962E1CA4AA9FBC9C0@DB6PR0202MB2774.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(8104003914727);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2774;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;4:lbb3qsl2h11NQTL97Yg14L0XKR0udGYb1Nl8UOhpLRG+b16TDhB33+9M524xGWC3bYCVHgJDRMP6BFEG7uNk6DCnO4i6NOXCsH9gQ4KZDE3mb4uX+gZWOMVAg1+961CFEyayIrI/vAMPUVlJ77qYCLmGMkxEr3NSj42veX3IQCT2Hd68YWq0UFyxt7Ms4aRv4/XDoo1v+TZGgGwYkeZDUnIujiXMKrEEExvWwZiu+ov58VXHIalN5zsA1kmK3xmTWJ20KqZIgTGjCB4aPPiZmDRFXsA9pBbprnSfrBYlC71S2rPcGpUUoQwqkYYtXK9K1GN4hS25fdWDtkwiCIBeyaIs7RcDCe2cI1NryVr8sKs=
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(366004)(396003)(39830400003)(346002)(376002)(189003)(199004)(377424004)(66066001)(4326008)(486006)(36756003)(31686004)(68736007)(316002)(3846002)(6246003)(65826007)(65956001)(81166006)(6486002)(2171002)(65806001)(53936002)(8936002)(74482002)(86362001)(6116002)(81156014)(305945005)(230700001)(58126008)(77096007)(11346002)(59450400001)(31696002)(97736004)(26005)(64126003)(7736002)(47776003)(76176011)(446003)(106356001)(386003)(476003)(53546011)(5660300001)(2906002)(50466002)(105586002)(110136005)(8676002)(52116002)(2616005)(36916002)(23746002)(186003)(16526019)(478600001)(16576012)(6666003)(3260700006)(54906003)(229853002)(25786009)(956004)(117156002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2774;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:3;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;DB6PR0202MB2774;23:zu1Sve5UhKkUu1VPbUogliNFQjHkGgG8BiP?=
 =?Windows-1252?Q?7oHdxGPuZWzG2lLbBa/ddHrII76LNgTGqM+uxrz7I5/2WVJRKMzHfSsZ?=
 =?Windows-1252?Q?3OBz3fRF7IaIE9sXR9enZAVPO/e31mOR/8EjVX1Xnz7DwugaJk5tiUwK?=
 =?Windows-1252?Q?OIpiszkEkSkHRNGTAYFm81pauKIMmkvaIT1ljlJXM3Z21YjyZLDmq03i?=
 =?Windows-1252?Q?eXyaRtFHVVpuRsgHG3cLNoityhxxbOlVTAWL1DbRMxMugOh97TzJSjGm?=
 =?Windows-1252?Q?2ky16JIZFo8wM/ppYfUYGeZXtOukN8t380GN9OjfmAusZ7N4k1JDorgZ?=
 =?Windows-1252?Q?1gSE6NBfSoZcr6pEsc83QtYnjvp2vajUAH9Q9+w07KRZKmCXXZIhRG+X?=
 =?Windows-1252?Q?OJkeeNVCWBTvsSxJT+BZ6aEA0bhHEcSnYBAv1HGTOEWc4w4BJABdqcRZ?=
 =?Windows-1252?Q?0WRIf1BdTduhlCWxefTRPpe1bdZLIAc+GZxethjbF3TaC4joosQIN24r?=
 =?Windows-1252?Q?l4PGS+WnRdYJ0Ja26qhYOQb3/oxiEbW1v/vqcjFWmFoL3INEaH7MR9w8?=
 =?Windows-1252?Q?CgTi5yvsRvaIQNy0i07DCQvO8+QzKCWcN3QiOJwRqkr09Evt20BEIZJk?=
 =?Windows-1252?Q?yDi8oVoRLvbOVdGN7p5mMl/jkb4G6wrMAP2+oQzIDWRqzowujc+FSAfU?=
 =?Windows-1252?Q?8tkVhmglrm+r2I/pqyYrvqglVoI8TCl0AHCS0zqz0+V78vOU/bWYYINJ?=
 =?Windows-1252?Q?x6GpU8TafGSp0JZDnqClmpVzsbWYtBMed3ADsSR64qSWCCaugz/iNQtv?=
 =?Windows-1252?Q?zB6loLZnhlhlCKkP3N+xn/UrOA4bwLe3HbWSPyPeIaORUGATYH0Azi5G?=
 =?Windows-1252?Q?ySb3EBs6fcxnHikR4YPJBqDhG0Fmy6kGrjekhr9T/RhT8ppQYElNK7ZB?=
 =?Windows-1252?Q?hJ5cUu/CbZnEoV2C8QFeqd5i+U+z1Gcz9B31GF7DP/3LDaRwam3YmmHj?=
 =?Windows-1252?Q?WH7yqL69YHPuG9G+dkfbJiIz3+1NxWnbbcyunWcYCEl4GS9LXIfIPHC7?=
 =?Windows-1252?Q?nNlgUwdCk+lnwpRBPicEVZGfj+0zzn9ZW9/tkTba+t4w7+3491SXtguM?=
 =?Windows-1252?Q?IN8LZdKVJjCjsXn2+JhFEVZcmgjbLCLf/grVXDACSc/jbCKTP+4Ah7gk?=
 =?Windows-1252?Q?vJuGjc9u1YtFb/k4npBBUivexNwI8y0lSe2L8TDRksBf2XOZHaeTul8s?=
 =?Windows-1252?Q?b7iV+h6+FAsDat8TzzVFOo76/ao+0z9mMcQpN+q8f8Zt5LfelU/UD5MW?=
 =?Windows-1252?Q?7gb5noYBsW2/Fj2thghBofj9mp0IhuVWK/P6PrBab8iGrNVX50elup+0?=
 =?Windows-1252?Q?oyv3K6Y7oLIcjjN8oMDSBt4A7Nc9drUExfxsi7w/NOIlbY6+fTLAS97z?=
 =?Windows-1252?Q?vZrmDVoPYgXweJOC3LMgdD+wd8LU1noVFEG/ADYr2JZojbt35E7WLZI/?=
 =?Windows-1252?Q?6NjeD0+b9PUppfnoinSo3E8Jn9F1Y3Y7MJ0kOOGFRNYJJrdqn9nmIQKv?=
 =?Windows-1252?Q?yNaUqNlTkunCSmSTVJEPe2Scw09KXylFivX8h5JX221NedegIkWSmqcm?=
 =?Windows-1252?Q?X+f58QITLkgoFrv1W3MKqyWkb4PlOXxx6L5sa9GimxaW1vhrfgYfCRuA?=
 =?Windows-1252?Q?uLd+OUpdhG/CM1E/8FxDeLBXThKDVLqQ=3D?=
X-Microsoft-Antispam-Message-Info: KhpVOjKWfsjZl4R91TctYfj5/LNFDap1bz3aq23zt6zpk2952bfNwLhUhXHl+Ib1lap3Pb1MhT38EDZRQzifpY/Qw44j257n5t16f+TQ/clWVbcd54kuYZYd0WGCI6hF9QD23v8AOaeO2DieUfMpuCBJukQSJpCu6qCMzgfXf7z8rjfOWR4tB2UB/TDa/c5P
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;6:h2jt2q33ODFz70bDmahG/lJC0VhWnmSTHtVG603gdZfd8S360pgfokhosKxn6w83DaEJEMCvgRBen7oJa4MaMfmybnNtizzyja02TUBibjkc7p05MvVoWMIhSfeAzruVoTp9QSZZa1lZ0bmEag8W7AU0B7xPvOPxrbFoApJZyPWHp8q3ZTNsHXQXVWAyb7HYHSU4ycgVMKtCTLZjzw7f9If57waPG9FEAOaYK8QkPIsULsO/ERJwS1svPH/gp8Z4An79QnnhumoliKp/X0/nDmRZBc8NwFXW6e4QpH42xeLOBoMe9eHMypE2fCFu0IP4T59RtT7LY5ZlqQ0TvC7mGMAhXIVhk8UaAdSb7jptD/xbxq1kW7oL2tkI/Ae7sNmjTeiDiRm+RJ9319KqQ+gkdSjtVDmFQJVnUz4rR+jw+LmHj8oiiqtqkFj253hGBqgs9B4IXqG6VAJuE9q2UPlHPw==;5:7p2NOniWBUpOxk7fP9VTiTs4QPslv7Xp0mtQLaM2Jkyqt3CIYLZhstshDeudM6XvoAZlEPbiCdQ57dEUFuN5qwbLsHht8ZDCiECV95Gss9zTJk0zb9ro7I7m6zfTQjRB2M59lpxTFiaFv3cp3AKkX630TegWu9uQjtMejMcXSJI=;24:a0TP9sVEwbbCBh4PvM+grrvslNQKVi+Ai3DQ2Wm220e2jEycmSs2TrUbG40gQ2FX/T4fAVN6pCh/bWHk/HV8C4/o8iDRVQoYFN92ynKmiSQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;7:FpHRmDfCyfQgHgp5d4EmKCRp+B1VyClj8hQbeYAhBJAfJVlQyfnxxM2+BjK1X5EFMzi19kQXKwN/MwdQNbKJHFWju4LfXK2FIJqJrxI5pCMpcUt7Rn1bbe7cIr2GV/zjlLYHcMG0WeJmvfz9Fz4HWLck8KjtUf1elqmlmZ+3smf1XvRKt/6rvJ2sAOZiLrNXeYN2BfCzHXrsSxuoOwLMzHP/d99NtKPGctYADhLglcb5Is2OfhQSQ5orsTh0aHfz
X-MS-Office365-Filtering-Correlation-Id: f5d8e7c1-e822-4d93-d18d-08d5b9d9a257
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 20:31:12.0655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d8e7c1-e822-4d93-d18d-08d5b9d9a257
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2774
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-10 13:17, Wolfram Sang wrote:
> On Sat, May 05, 2018 at 07:57:10AM -0500, Wenwen Wang wrote:
>> In i2c_smbus_xfer_emulated(), there are two buffers: msgbuf0 and msgbuf1,
>> which are used to save a series of messages, as mentioned in the comment.
>> According to the value of the variable 'size', msgbuf0 is initialized to
>> various values. In contrast, msgbuf1 is left uninitialized until the
>> function i2c_transfer() is invoked. However, msgbuf1 is not always
>> initialized on all possible execution paths (implementation) of
>> i2c_transfer(). Thus, it is possible that msgbuf1 may still be
>> uninitialized even after the invocation of the function i2c_transfer(),
>> especially when the return value of ic2_transfer() is not checked properly.
>> In the following execution, the uninitialized msgbuf1 will be used, such as
>> for security checks. Since uninitialized values can be random and
>> arbitrary, this will cause undefined behaviors or even check bypass. For
>> example, it is expected that if the value of 'size' is
>> I2C_SMBUS_BLOCK_PROC_CALL, the value of data->block[0] should not be larger
>> than I2C_SMBUS_BLOCK_MAX. But, at the end of i2c_smbus_xfer_emulated(), the
>> value read from msgbuf1 is assigned to data->block[0], which can
>> potentially lead to invalid block write size, as demonstrated in the error
>> message.
>>
>> This patch initializes the first byte of msgbuf1 with 0 to avoid such
>> undefined behaviors or security issues.
>>
>> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> 
> From what I can tell, this patch is not needed anymore after patch 2 is
> applied. Correct?

AFAIU, it is only needed if there are bugs elsewhere. I.e. it's for extra
protection. If all drivers implement .master_xfer correctly, msgbuf1 will
be filled in and the return value will be the number of messages (i.e. 2)
OR you get a negative return value and the msgbuf1 content will not matter.

The patch does not magically fix all possible driver bugs, so in that
sense this patch is still "needed".

Also - again AFAIU - there is no known bug that actually gets caught by
this extra check.

Cheers,
Peter
