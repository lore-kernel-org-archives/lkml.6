Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932408AbeCJAFv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 19:05:51 -0500
Received: from mail-eopbgr10123.outbound.protection.outlook.com ([40.107.1.123]:41728
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751211AbeCJAFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 19:05:49 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 0/2] check I2C device id for pca984x chips
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>,
        Adrian Fiergolski <adrian.fiergolski@cern.ch>,
        linux-i2c@vger.kernel.org
References: <20180305205822.951-1-peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <7fdb753f-2330-e93c-bbe3-e59fd96a253d@axentia.se>
Date: Sat, 10 Mar 2018 01:05:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305205822.951-1-peda@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0181.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::29) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 504de3cc-5e7c-4d0d-5bbb-08d5861aac3d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:P7hzpWMRA+U294nMYbTVpFuTjx1HDb+2wIJXUhrXlKMLyzXwu6JyafBlybHxP7sXQ9uUD1inZG5AmenqRJ3pJv5iONqruo++KB0r5LPiTqXTeHbDJLua4yH5ZoAMHa1BUWnb4A0CmOtJU/kNLBYqrIox1u1/6Iiqxf9heeA3eMaRbCaxs9MIUzZwXQ3yLzc4gLu+l+3ilY7WIzuaqQe8YO6SG9eukAB/J8lDI2FKkKge/bmuwbIXTgqOUEDVzdcQ;25:tO0bfQaXB/r3a+QqhUx23F6oHNT0fEa2ITqTj4b10PzDydnfgd/TgxYHHDg99cc3Emde+mtKIBx33DSEcINzFt0dgdEYGg5AtBSm8KXpDIcv43whB7h6ZzXU9MTJAAbiUKkwDhFjracPybKUagLcjqbXqngwn5V1iskAxCCFXvs3hkxGucVdgD67VX46tV1flpQaekZATgfz2QtntiXdgmemIAr9ZOusUhsaZG35sLKXBEKIEGwPidm8y9Wwte7mQve/hykvpVyL0NIvyH1iHIhLZ83rGJ2D37O6iJVLtWdbrDNoBmxVP9HaK2tMvdwrJGDNRJoBy7xXbG3pQW1yRw==;31:jFXQuulNhQRhgPs38z1j2aCEU/fFsMRTOM9je730hHCEoHiN5NdzbsnMfDPhk3Vkh9Gwbx+z0qtY/Vd4Loi/8xviunX3lFTPQ1l6CvCwjLmIQZWWL+O8dmR6b8tSqoXyuaUs9NRIZZfMjrk2pyBzxldMtQPh9Ub1mfqaMeAML48aDe/NsHP6R36+uSdSlFFdk/wXSeMP/guwjeEZAqYZC90lsnGAAmwweRl1mtbz8T0=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2775C7B944BF29BE495BFBAFBCDD0@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:ot26TbPvbiPjQ7nt4sXqK/wCwbiOEXt2Lb0xnH1a8GDZUZyL//fnEKjMA+SinE2OeDbASKd+XZjF2UlILlNlzdY7IC9pPxPs9KaPuOCAobgFmaJPHMM8P4p1zQj2CN0Gj4/6hQAbgh7x/7W0Vwp2gPdrHRXwM2mLr8/qpUeNOLYRvnAp362cg3JWrhtpcNp/D/L1BZHCdV7jqrdfJ0MGGJIBWwx9+8h/XhgiUV2DaBb770LABT9cF0UKpyjbKYZi27gFv7Tk/PNv8qIh2AmKrA==
X-Forefront-PRVS: 06070568C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39380400002)(376002)(39830400003)(396003)(346002)(189003)(199004)(377424004)(36756003)(6116002)(386003)(3846002)(6246003)(53546011)(66066001)(65806001)(65956001)(186003)(8936002)(2906002)(81166006)(65826007)(478600001)(7736002)(3260700006)(25786009)(117156002)(97736004)(6486002)(8676002)(81156014)(2950100002)(6916009)(50466002)(305945005)(316002)(64126003)(74482002)(52146003)(23676004)(4326008)(52116002)(229853002)(16526019)(5660300001)(76176011)(53936002)(26005)(54906003)(86362001)(77096007)(36916002)(2486003)(58126008)(16576012)(31696002)(230700001)(68736007)(47776003)(105586002)(2361001)(31686004)(106356001)(2351001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzU7MjM6dW93TmRmc05VM1pxQmFKY05hY21NZjFW?=
 =?utf-8?B?YjhDOGZDMU9JaW9pemJ4dWVwTTI5RmhXb2tSYTUxdkJ3azlVNjJwVTl3dW1y?=
 =?utf-8?B?WXpMU3VqN3JKTWt0V2E5Uis5Nit6S0tzTVdLTlljR3k3VStVK1VwY3ozZUJK?=
 =?utf-8?B?RmRXdWQ3MFlwZVJLL0xxRll4cHVsVEprME1QVE1BYnZoNUdtZnB3dXNTYjg2?=
 =?utf-8?B?R084QlV2NHg5cUxHU25GUnRLU20zcWN5bEU4Tmc1WmI5bXZ2RC85ZXpsb1M5?=
 =?utf-8?B?SG1vbUoyL2FjdnFoKzcvTXcvRGdsMC9tRmY3Rng2bFNSOFg1djBZL1lrUzd1?=
 =?utf-8?B?V05INmxYMEJ4b1FaVnQ5Mlh5S0ROUTRqNnBEa2huOFNnNjBJOXVuZzlDUmZI?=
 =?utf-8?B?OG9lVHhQaitOR0NldEtUdXdoVDBvdzBYTERzYnBzS3liSFNieFVCNG5UYk1G?=
 =?utf-8?B?Z0dVVENycGJqcnIrRHVLNHJaS2tPMDJKeFhNN1RHMEpsTmloc1UrRXk3OUFC?=
 =?utf-8?B?SEhsN0x4cTVxejg0Q2tZaldncER1L2p5eDRrbGxuSXY3cG9ocjUxbDY5ak1O?=
 =?utf-8?B?eDlhN2dmY2pCNS9LdHhqcG5oanh3R2QrbEw1dGx5T1o3Sk1TUjIvUUg3Zk9u?=
 =?utf-8?B?TmFoLzY3NGhEQWVRbE0vY1hRMEFSejJKTXB2RlBKV3VmTTFmZHByWktHbkxE?=
 =?utf-8?B?SkNtb2E4bzJLS3J5RXFBV3RtejBtTEJJZktzZDJFaS9VdXFabGZmRTM5cUY1?=
 =?utf-8?B?bE1TYWc5MmpJKzJtUjNVV2tKdmFIQXc0eTczcFk4ZVJFYWNnOGM4Wk1PQUVu?=
 =?utf-8?B?eDEwYy81cWEveWNyRXJKcDg2SE5Lam5ndlozeFJXamY0cTBzSk1WUjg5TENw?=
 =?utf-8?B?WG04RmI2S09Ic0FKL3FsT202YnJmRzJkRVNIODhMTW9WWlV1c2hpYXdyMlNz?=
 =?utf-8?B?dmRPMldONnpqci81di9GcHdxZi9Qd1hXcW95aGF5aHpvYnJGN2t6UHRndTdO?=
 =?utf-8?B?Z1FpM05XR0lqczNjcHR3U2FtbGZpeDRGa1E0ZzZDSlIzbUVtejVib2pFdzlu?=
 =?utf-8?B?NmlLS3lMK2lUNG84dGZwQWlINWszaTZSMXpGOUI5SGI5WExEZEdMOVVMOHF2?=
 =?utf-8?B?N3NtNFBnRW9xWEJEWTJrODhIb3pVQ0V4cFdPd2FWSWFCMzlOSC9zbStlTjBr?=
 =?utf-8?B?cXptRWdlYlExQkpvbGRacVo1ZzdCaVVkb05FaXdjYjFBVm0zYTl5ZTFzdGVB?=
 =?utf-8?B?dUpZb0d0WXQ1U212NnlsVkp4SGpIaVJ2MFlkU0h1bVRaTWJYN3hCUFVtV2dl?=
 =?utf-8?B?WnphdGNqL0doL0wyVTlxUG9XR1RiY28vNHNiOVVFSW5GWnlyNWw0Q1FHSUoz?=
 =?utf-8?B?alVBMU5ya0s4SlJTdkdrTVV5RE9iMWhvaWFPNUJ1RHRlRkd3Rlc5VzBXN1B5?=
 =?utf-8?B?dDJ5QmViQXRSMzlWS3FQSnNDV1lteE9leExRTUJzK2NWUCtrcXg0TENWNElW?=
 =?utf-8?B?VTRJZlMrRXR6bmg5SHM0anpwckp0dTFaVy8xY1NkaXZld3k2YnVLZmYvdUFK?=
 =?utf-8?B?VUVVQWhQS0VCUTUzMitUWWpZdHhrdVkrZWY4ajhlKzZvelVtTmY2M2h4Zkln?=
 =?utf-8?B?a0plZnZjcVQrL2VuWVk5RTJob29vUGFwVDRxODV1WExaN292RDFOUkNsbWFM?=
 =?utf-8?B?UUROWkRJVSt6T1lRa1JsaXRTSnhDRVRuLzBkenJyOUZRZHVoSGtnRk9UNi9I?=
 =?utf-8?B?MlpDQ1I3MDJmaXdSRlEwOUhydjJGeEFsRkwrc09MQnJMQ1IvWThxOHZOUGJI?=
 =?utf-8?B?aDZhSDNuNVI5VGUyV2ZGc25CdW9EbXNrYnV6OXZ2bjlLWGN6c1VDMmkwWFhE?=
 =?utf-8?B?OXFsWXhlbTFiczVzUkpwSnhxVjV5cTVjdk5wdXdRRDJmbDNpMm42R2U5cU14?=
 =?utf-8?B?eWR5S1dSZGZ1bGRKY1dEaWF5cmFYQUltMXozdkZIM21EdkY1bTNnN09IRTVK?=
 =?utf-8?B?cFFnZEg4eTdGYlZld29kTTBCREpGaFNXUTdITTdEdUVKVWhrYW9wTUlrN1Qv?=
 =?utf-8?Q?QFxCkI=3D?=
X-Microsoft-Antispam-Message-Info: nM+2p/CTvAUDy9eGSJXgN1ZRpeCt8PyJS8lLQq2s/sndrZxgVZq7RsAJY6c7kQoSmL5PbR6e9a6aSglYqHWISQApWsuDjmW5IrAoGo4aFOn8rsouz9LU4RKQaB4Rmc0GwvOhPlcec+IOPN8neLnOMVmp99kdt+AA7pirjaWxUnwZBE2Ls1X/GuT7/gsG2vAH
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:Q2I7qMy1VLgyvx2yGqH9TpPKIxKU96EzEdoznXm5DbIBd/KTEqM6tcsEMvTk5Rqd3dmRzjNmJHxFR3QAZc0sUyc6QVFcxnW3HIaZ9IT8V0CSUu+3vJoJA4YFkjuEf/T3y2KHyRur9nTFul6g/ul/gogOiN24LPsRH2940Ugxxcd9TJnelW1CvGV+qZaz2jRMii8r4odZEH/bLGxY1qgfesue0fNTmutnldOM2VZZ5QQljA1jN4dl5DjgAZWMv/5hvcj02KUD0j+Mc00pSj+KX8Vr+BOvHhhS5bMOKCGpAPj0kmENTl1XwRY79aNW2Vok3q+FFwffSo+Gx/BMALVO2aChNgBxm4NRVP7jtUJUCmE=;5:TACfhYw5TkPGeqL7F4GAUOu31ZYEzC9vDNOSV2x6rfa1TnXjFREmF5Y9omiUowdYIpjWI0/XBQgsZZDbywIcwnm6ocCG/82+2c1YMmX6AzMtaDpnxG1kCj8DJLm7F/JnOgt2QKuguik4hsGN0JsMTPC/9btrMURG48e438f6U4g=;24:FI5uN7En/dMMm7SYI3qaDcmvlWSzzmY+ov70rt/lPepSfcPGD5RmNMEbQ0S0I+D5icIlJhIY/kbZ7RrOTTez73/F2VJ0yq4VWk6ORbpcVjg=;7:KkzQx0ArW2EO4rBKEBlLvfwzVZ4GYH2mvABX2fKaBvacwDPZdE9sY35zJh+sOS8xWsZtfzEIg9yErKv9ioy031bYM1VCI0YOk7JRKRnlYz5L/qu5sFUqcgnUN3QC3Yjdt4JM+vi6Ln3lfZLnwaKnrIjehL1b9GqhAoP/GgrWCfVDdbwSEwWRLXwyQlZ2g9mkJDlIWlPhvbst/My74E+tOV9qKwhxFoJak84YB06sSpVU9y/2/JqVKZtSiWKkqDXy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2018 00:05:45.5548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 504de3cc-5e7c-4d0d-5bbb-08d5861aac3d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-05 21:58, Peter Rosin wrote:
> Hi!
> 
> This series tries to check the I2C device id, but instead of open
> coding the check in the pca954x driver, I have a new function in
> the core doing the work.
> 
> Changes since v1:
> - Added Tested-by tag from Adrian
> - Added Reviewed-by tag from Wolfram
> - Replaced client->flags with a zero in the i2c_smbus_xfer call
> 
> Wolfram: I'll send a pull with the first patch in a few days, to
> allow for a second round of feedback now that the RFC marker is gone.

Both patches pushed to i2c-mux/for-next.

Cheers,
Peter
