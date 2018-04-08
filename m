Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeDHJIs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 05:08:48 -0400
Received: from mail-eopbgr40134.outbound.protection.outlook.com ([40.107.4.134]:55601
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752111AbeDHJIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 05:08:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [RFC PATCH 1/2] i2c: Add i2c_verify_device_id() to verify device
 id
To: Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1521475859-16765-1-git-send-email-linux@roeck-us.net>
 <20180408073435.i5nq2ngx2fslaz6a@katana>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <336870c2-b6fb-3933-708f-67036bd6668a@axentia.se>
Date: Sun, 8 Apr 2018 11:08:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180408073435.i5nq2ngx2fslaz6a@katana>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR07CA0017.eurprd07.prod.outlook.com
 (2603:10a6:7:67::27) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2382c20f-9028-4679-2d59-08d59d305361
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:Ib9B38Yxr+pOBln+3HutRW0CQQAyr+9l7rATDzo2xbgj7smR+zxf1kC5t1xICRyI4z48f6vUKO6/uXHpm2JSZ9xuvczIk1XfRYX9ZNp7pz36SKMWS0fZwic6XzazJL5vZTTOqQHZTYh1lFutQQU7HwI4jFPohISMnc6nXbExC/iseARkcaJJYkm2C0cxJRY4aKJFOJmPHcVR/Y2lY6md9Lr1Ztua4KTtT3+/2lz1l1uo7ghCxckth4yfTDeZKoXS;25:MPVZVrDqPDSTbhOJShnzdrFqJ5eLiJ1ViSNQ4BstdheehIw8TV2nxuLP6UFoNRgajGR6AJ2B5lYbgLAc+zOuYnzrtpIZYcqwm9QapNTLzbRxZWSIZcspNxZ/uocaTKShdZsBctlXyrxnKZXVJAkRlmtngcQDQ5V+lbMRvAJ/cRDwuuavkFtoZCJjGoYIjt/vT8q8fWKNWufnm3Nrrd5xE0mTQFWZeopuIEsIOTYpC5XvYObJZ48LnIMWvB71PCkfdv56y+FLk7p2ZFdRp7PW/7DT3gDTTFcNTzUWsmnMgEd2gOALUz5uwYMcob0lyyO3n8CZeefAopdzo525mh+l1w==;31:gWUuUI8/Uwb7aINqhMT8unJfpL27rNxcAeBnYbqV9OTgu3kZtE65p+5cwjShc4Gf7wFl0NtWJLU/mr1M405gHv5p35qKiNhE+nCvkz0ZzMOiqNITs+L3mxaMazUX1izYDooYbnAmS6m14WmpfUfxAWFQOLfTWrWclxKK57Xy2NyjK/VeNg/p6gtgL29bQ7VBvT32prGEFX7/mtLW6lezGxZrLWmF1DaYIiLng/ps8nU=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782BE7060D26995544E4FDABCB80@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123562045)(20161123560045)(20161123558120)(2016111802025)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:Py8uRsOwTsyLKITkv29i1z4haheHwOfXpPr0vFRkWzmCLCyGivyTIKbIMZbIO+rV4exJdMFy8c2GRylw8xMXVcncxrXeSRHvv/cHtx6d34weDYlpe3NmZftMiqph52VnkHkrlpkIPW377iUKyM3Uz7g/ZDQ1ZlHebhkRcDsFsHu/qwPHOYsOpnSlsmkZXGRzmBieXw6lRJ9Lv07WKytCbbUNS84CPzugygt0Zf2MC2TRYxA8tj3PFYVbLLuBxSLUqCGSXYcB0BulHdXy0RWxIQ==
X-Forefront-PRVS: 0636271852
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(366004)(376002)(39380400002)(39830400003)(396003)(377424004)(189003)(199004)(186003)(47776003)(26005)(77096007)(386003)(52116002)(76176011)(74482002)(50466002)(31686004)(4326008)(6666003)(106356001)(2616005)(25786009)(3260700006)(956004)(11346002)(117156002)(110136005)(15760500003)(316002)(16576012)(58126008)(16526019)(476003)(65826007)(64126003)(59450400001)(5660300001)(81166006)(81156014)(8936002)(31696002)(8676002)(86362001)(2906002)(15650500001)(230700001)(6486002)(229853002)(7736002)(53546011)(36916002)(478600001)(305945005)(36756003)(6246003)(105586002)(446003)(3846002)(23746002)(65806001)(65956001)(97736004)(66066001)(6116002)(486006)(53936002)(68736007)(42262002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;VI1PR0202MB2782;23:l+W3DqXHpJise5y6ERz1c5fevGXG4Eii83I?=
 =?Windows-1252?Q?ShPMoCXG51u2EtKW8bkA+nkDet1klYHTyPX4bSsvqXeqmZiummaXvELd?=
 =?Windows-1252?Q?7TxnAMe89ZRHouUqU93jPNGX+p5pXcKWHfQkkoJCiJ7DGC1BXZ7eJ/rI?=
 =?Windows-1252?Q?OUInWF0VWWO2RJhOqrRhl3Cus5PFLh7EsEvSEXkC+bqeDG9W5gY3gFv2?=
 =?Windows-1252?Q?KpwAyZodIqPVWfforQYxwYyGQiUtco+ScWYV2NZ2yrfcZrkmvLTUWulZ?=
 =?Windows-1252?Q?ArJISeWCa0Lsv+sAj9eeDGmr6+/G/zof/5iYUQHoGVyyLpVjkoffnrMl?=
 =?Windows-1252?Q?w61pws5epvkz/vlFZUT3Ct5Td2eMKeonTsRuZsvUdQ3PGEEIJ/1yXnsZ?=
 =?Windows-1252?Q?s1Z4ITtjrkEfzaFpDfe7CkKM9IDKX7ENUs2UJ6vDW2TYewRECRzD9L1k?=
 =?Windows-1252?Q?gQAeTUgC/F2WilOh4Sc7vPMJprocSLjhBKbfChas88SG07Nujw+k2dn0?=
 =?Windows-1252?Q?3AO2nodqIdKE0aAb0cXIqX8i1b6LJie0KQXLbyY5gvtnWDCsQ5ovbh92?=
 =?Windows-1252?Q?pDOo48C2nvS5bocKibEePtPRE7CS79ysxbsiC93PMkNCPAMo4LU45Rrt?=
 =?Windows-1252?Q?MYZlwyA3A8VrVaSECQT/rY0N6SnQQ24FpGWa3ABrtzioGkssuB9AAUUv?=
 =?Windows-1252?Q?6Dq3g2e0sly8f1J5YRAJSoUkC+D74EzFFkxI6OYqJMFGdJG71oyrbHeQ?=
 =?Windows-1252?Q?2Jo64Za+yyhse4AQ66NU/pGVSs+tFleg7tCaErvNCxaaA46KAF4ogZdI?=
 =?Windows-1252?Q?6F02PS37CS+yrpdCmKdiQPfT2Rigsv5R3xvUkiLR0jo7CNTSH90/DyxZ?=
 =?Windows-1252?Q?VxIg+KcHcVGGVzMNFNIGEjCzlNry6LiizYJvTcntH6zn9jG6E6L2dqkO?=
 =?Windows-1252?Q?64emBq0vMWBOHYxHWMz3IswRzlgx+m7RSI+jiwhMTC+y1eskBBnDyHug?=
 =?Windows-1252?Q?feUNXRLWzZjT3pK9yXBoV5EXmsV8r8PZ5O5x7yoS+gOb00ocekVQsqAI?=
 =?Windows-1252?Q?9P09XpRbdeVTxrkBpVGlLwxBHzAybT7Y78oAf21nnpGR8gAR+8zyUtL0?=
 =?Windows-1252?Q?b8lLc0ZA0pRr1dA7C6tn8Zzj8FyRKdB6GoR+L1gNtiEGtXRVVy4caEUT?=
 =?Windows-1252?Q?RpkILJKSB7YGo7q4mHT2v1ywABsy3ru8KFP5V2qoheTqeYaBK+ABaRUv?=
 =?Windows-1252?Q?/yx10epvYaqyiB87+Yp5EFYWWG+Q82Qiw4Tstt2pb6ZGNjcs0zJFdkb5?=
 =?Windows-1252?Q?MlH3KiFZIxyZBGv8mr88+kwTs8kGlL4wCv4YqVOZE6uZIhr3qw7TyEEx?=
 =?Windows-1252?Q?Kb/+lomo4r8jLSPa9O9ZyzKJzkHEnG9AAZXRdjldek/lo+3wI/TYQp9N?=
 =?Windows-1252?Q?o3+qzj/seewpcyxhZZKqEL6NQCLrNlAQ0Rf1QhKbKCUzsCb4Qsoo/QUF?=
 =?Windows-1252?Q?vbVieFxnByRWh69u7vKVeXz+QR9LfL5rJh1N9QSTwgF0h9mvP7lNx7Iz?=
 =?Windows-1252?Q?fm7zd6ZeUtxPwRWLTR8TVLpPHHMebCBuxDn4sMFkCxpeDxelE3iKDw2u?=
 =?Windows-1252?Q?OHDeibU4Ta/vy64LNjVBjqpXkoxGpVMjD2vlCF/TmhnN83FY+gxyEm4y?=
 =?Windows-1252?Q?4GY0G8/PJV9+RoG4wwgO7hSTrR255NyMl6RfcNdZlixowHhqVZrfM2nr?=
 =?Windows-1252?Q?jHo/ArUbQl8jaPXrNMg=3D=3D?=
X-Microsoft-Antispam-Message-Info: 6yf+Fu4DafbgC8RzuN25RF7O64WklYXpmfbymm9K30M/ne/uOvXY/VakTBkvZHHoWStYbroWDpvfgvXQuHNNLTEbL/Gqc092ifX8k7o7hh+nRXPChBaCCzA/zn39Bnoh9LzjS9C/qX8MoAB5L46X2ezy6kewnm4sVDwOg71FbUdHgKLe5+SANZhub3Ccbf1T
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:Hxn6IrcVSRVUazwVA5ccAak2wPcydEpBzTSc7buEq0bON18YBx9Pgh3qa4U+DC1HX88ZwQEz16/iHX1LmRufaykM8OfIEyUshbHEXwjS9ZKsM4A8WPpGBOcHBaFGl0H5e9QhS2ZHLGlSF+y1/28azlhjJEpYqVzNr9Vww/mGsQbGB0NBDOY5PhU895xz6kZWjyFUFgGLsmVANZAAtGdmdfMLwIHLv2sY7xuGY+osmwtdcvYM9P6pvJoqr/Aes0gJZufC+fQWK4ZSQN0SlNI01axdzWyJ60lu5KQelZ1Rjoe3JxO/HsaSJpVXpczIMluH7WdzgYMcciTyK1BVFW94rerW2Wk/IDR3taWECLJ46KIS2TK9maeA8ykS8kMQfLAfdByxl7eXRsV594/XXC8VTs6c/Nh1hKLG+AomMXWZa049KKVPZomUs/Xrik+1u+UFF7C97tu2Bth+KsIP1nMUVg==;5:jW4kd/7ZEGNvYbmEr+EoO6454VOxQ7oGW2oJzlUCtbdQno5AzF0iWGXeQWhqkohhARa7bUdGnfp4GbAqJ4AbhPHQlcXJ/DLhpMIsq9nOX2BduOppv1qn6xZjT24lict/q3KUM+irwn76DfBi5NfeyvPU014VbB595j0JST3xE/k=;24:SmqCHGNVq5JiDZcdJF4THrNmTeJjEHWH93PZjDIJCp/U7DFCEo4IJcAq+OyqdfjcDrzG+D5WVTjeCIssUrWEiyYSraDgNJt6OQPLxnlsxBg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:dBG3t6Y+ukqnOS7bdxRtfbX3/gpAABebaEvCK6atDuQxwujC389WjKr/f8RdVonkIy1MqQ/ATpOaUmu3Fc8xB5hirIo1c/eeiQ0nVrQO8iJC4XUBzRwhVgztJXzV9DZCpLaxyfaAkFBpcuJLzqWBcsBEgEjwu69UsqGBBCtIBlxTHsw+ajyN4oviJBzuBtgzsej1vLujson8Pj7295LSUX+x08B4x117FYbndS9MHsxBKokSQUBmXceaNNQK555s
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2018 09:08:42.1442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2382c20f-9028-4679-2d59-08d59d305361
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-08 09:34, Wolfram Sang wrote:
> Hi,
> 
> On Mon, Mar 19, 2018 at 09:10:58AM -0700, Guenter Roeck wrote:
>> Commit dde67eb1beeb ("i2c: add i2c_get_device_id() to get the standard
>> I2C device id") added a function to return the standard I2C device ID.
>> Use that function to verify the device ID of a given device.
> 
> I am very open to these patches, just...
> 
>>
>> Cc: Peter Rosin <peda@axentia.se>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> RFC:
>> - Compile tested only
> 
> ... I would really like to have them tested. After that happened, Peter
> and I can figure out who should apply them for seamless upstreaming.
> 
>> - Should there also be I2C_DEVICE_PART_ID_ANY to enable maching
>>   against all parts from a given manufacturer ?
> 
> Can't we just add it when we need it?
> 
>> +		dev_err(&client->dev, "unexpected device id %03x-%03x-%x\n",
>> +			real_id.manufacturer_id, real_id.part_id,
>> +			real_id.die_revision);
>> +		return -ENODEV;
> 
> I wonder about the ERR loglevel. ENODEV is not an error, I'd think?

Well, in this case someone has said that I2C addr <xyz> is a <uvw> device,
but when verifying the actual device at that addr, that's not what is
found. Hence, I think an error is appropriate? On the other hand, a driver
that can handle different kinds of devices might not want the error. But
for that case, maybe the driver should be using i2c_get_device_id() and
figure out the details by itself?

Cheers,
Peter
