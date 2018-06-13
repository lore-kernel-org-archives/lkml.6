Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 07B68C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D93E20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="Ogo/+Ui1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D93E20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933976AbeFMGnT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:43:19 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:48627
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754475AbeFMGnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LGOccaUm9USbKpW9ScUpdabWJzB0vjQbSLEvUwbjsM=;
 b=Ogo/+Ui10yUdYS3HwgDAbBiI+4uXxIIkjLgvNGb89Y3uV7gklOCaG4jYxvakGFM9GfrhbfafxJa8k+nkeWEsUECdY+6+hdw2gcIrVzMUbZgOEC3p0qPjsBwGp37TUxwNpRiokdwkAgcZNT36Y+EnPQ58/AZxanDtfB9CxSX1p20=
Received: from [10.17.182.9] (85.223.209.53) by
 AM0PR0302MB3201.eurprd03.prod.outlook.com (2603:10a6:208:9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.17; Wed, 13 Jun
 2018 06:43:12 +0000
Subject: Re: [PATCH v5 1/3] xen: Sync up with the canonical protocol
 definitions in Xen
To:     Juergen Gross <jgross@suse.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, lyan@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        andrii_chepurnyi@epam.com
References: <20180612074856.28451-1-andr2000@gmail.com>
 <20180612074856.28451-2-andr2000@gmail.com>
 <9c579567-ebe2-f465-5443-b3a3e71d34a5@suse.com>
 <20180612234020.GI38773@dtor-ws>
 <3605901d-4a72-3f5a-6d74-cb13d2414a0b@gmail.com>
 <D53587A2-5B1B-4D8F-8772-04D453B93D38@gmail.com>
 <e1d62036-708d-5087-83f2-0ea32f3a6e74@gmail.com>
 <e038df38-95be-b985-a2f8-2532f51736bd@suse.com>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <67842f2d-2aaa-58c3-63f5-3aa0439457d2@epam.com>
Date:   Wed, 13 Jun 2018 09:43:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e038df38-95be-b985-a2f8-2532f51736bd@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM5PR0701CA0010.eurprd07.prod.outlook.com
 (2603:10a6:203:51::20) To AM0PR0302MB3201.eurprd03.prod.outlook.com
 (2603:10a6:208:9::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9606565d-3f34-4455-58ee-08d5d0f8efb1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR0302MB3201;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3201;3:TVoIgDFfDa9D2F8lodEHuY+tEvVFIB0HgnKtsE9QFxVpUa7diTJz51mQUunCsBizSMKZPqI5m/DDBZMs7DnXNdkSou3aQ5oUIWw5t3PsBZo+5yOG4KQjw+7vTdS/laBIO3OpeQkl8Wfl4OksJOjMmGrBSejDGymZv7+rIgFNLH9SQVi8h9S1FsU/P01Qd+OV0/N9pqYKAlTuhDtLvvPNqalF76prLR81SIbvroZCNi/LmKgnLXTqEhISZ19n91yv;25:0y50vGfWoP9gh6mUVuE1RqzZsL+FC8uRXddco/KUAWuDsJskHKvCM6EJqUkvAxgpDnsDa5V+4VZSIWdn8WoOkxzCblfPDZ8g8oB2pX9QOhCPNIN+ka+nzbhL2uxkwPBNtxicqUTQjkYmVmFSJlB5MllMNr9DPtZQziCYZqplqaqJxEWgVMORII1IxjjDZ51IYwDW3LS/JI+E3SIiaWOHuwHoFyo4vQ5N25JhMNA2mEdfyznsqmpAXVfiiGZFNp9DQTnKXD8rv9dZzR5tMd3wmNblXD7VKH77SqSaYX+iN5C/1bLvxXGTND+ipfTDVAj0S1GTebx9wguqVG/riqQfuQ==;31:kIs99zbKCeB2DNRhjNHTIKx3eoE3YUcyLB4oDG8bzLIju822xk0ylIjCu6WttOvsdP4PWz9RhPhnUbRuIb2e9OMtyjzMiItf6IgdM+MM58k4grjirifmADp0RrZVDuBLmCZlI7VpkgbH/50aUZvyx8s6k06lfCRv8t3YzjKRtHr++p6OrEOUE6+gS7eGwvu8KaJ/hYEDTcR2z3ETC4cUT9QezO/5z9gs69qIZZvx/SE=
X-MS-TrafficTypeDiagnostic: AM0PR0302MB3201:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3201;20:hVQiuWw6CTGS4XbOcj1ZBdU7b++oNhjs4+e0wiwS6jcJ+G+Iea9i5QlIDGPUBkPdtxwweua3+wOGvfiHnkldLwVCDNj+kZOxVZjozoMD8WvIj/pt99a02J2iXnet+t21AgkzR6BbKxGh+EbXu3K/nOCxRUK4DAO3pTVDWl1tWQye65R/wuNsIAIrIlcJGsWTp6BgUBmUDkv1XYEDVmmbKMfyIDmjZEgOXVTa1KZwkvWeik+Xry7F+kRDDGCn9lItXKRIZwiTtiTAOBJAZ0eZZx01rlR7jXkqvbFmt0HELAXXDNvZFG8e7wIDl6DnRK9WTmRev/6MjZY1yYnQqnWaaEYSBXKKx983579l6M8Ohq2pYCafPwIQ+iHWrD85wchee7S8EnGMgRCIFu+ywLlfhpF9bHx7p6xE5Z6zDaFM1NP1K4I7zB4y21s6X5rIaDGrZZbDDlT34knw0EtCXa1ZPpDdlwXZKljRzBEfjzTaHt3dqaLbjVj6GMFECY6TqmyM;4:A4p6wvXajWe8majE+uHJjhqJaVb7VboJ8PjwAdLTGcpU5/GZZUlkYd9vpBz4SuGOz40cQsd9FeAC5fhfeWlboHwT0pIJwdBMPKAtW/j5wCDl7GWsqCtsIgQt0gI6hlau6wE7K3LkA3QHolm1bnOTtTR6jWswFFH5+NO92Q4eEhX7F3HM6R7XxHGTPuAEn7cYJoPwB92QNpI7uVeJ4NQ/2Kn4kgkpk2dqF/A4Ok0SKKFrFbC5RIwkdgxGKQQRpUp9Z8NNWNQTCGRBC+aOEreCP6ei+PnmAX7QmVTDUArqc7yjms78ySdrQXii43uWMJO/Pjkrni71mh7dwYsG060hX8FzQIKWwtFjWD3K9aljfymh9wiNE4ESCE4J5mx1BbtFmqocUI9SeSv8vQOR49wXghCiB0iZWQ2P1bBVpbOWWU8=
X-Microsoft-Antispam-PRVS: <AM0PR0302MB3201D78177DCF668A8B2D48EE77E0@AM0PR0302MB3201.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(4114951738403)(84791874153150)(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR0302MB3201;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0302MB3201;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(199004)(189003)(106356001)(2616005)(105586002)(76176011)(64126003)(67846002)(110136005)(93886005)(68736007)(58126008)(31696002)(446003)(16526019)(80792005)(26005)(52146003)(956004)(97736004)(59450400001)(386003)(50466002)(23676004)(53546011)(77096007)(52116002)(2486003)(31686004)(316002)(11346002)(86362001)(476003)(486006)(2906002)(8676002)(478600001)(25786009)(229853002)(65826007)(65806001)(65956001)(39060400002)(305945005)(53936002)(81156014)(81166006)(66066001)(5660300001)(16576012)(4326008)(2870700001)(6246003)(6486002)(6666003)(3846002)(6116002)(8936002)(72206003)(7736002)(36756003)(47776003)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0302MB3201;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzMDJNQjMyMDE7MjM6Rk5Vc0JBR2ZCOGxqVzhNSkh3RUNnR3oy?=
 =?utf-8?B?VGJzVGV0Y2VJNEgwQmFhckpFVSt6VENvaUVENEI2OW9rVExWSmxvbmorLzVF?=
 =?utf-8?B?U2p4clVBNnhXRmNZZE1oVmVFT2F3L2QwR0RVTlM5SWVQRUUvcjUwckgxWDJz?=
 =?utf-8?B?RFdjT0laelVYZ3pLeUlqMTV1UlZrUVh5NmhhTlo0NzFoaE8rUjdTVDdJcnpD?=
 =?utf-8?B?Q1p4ZzRXNlNvSGdyVVFwcmdvbEV5NjNBM3RjTEtUTlNhNDFpcXhlUGFZNGVK?=
 =?utf-8?B?MVVRZHNodWZjRCttYzlYeFV1cGd1S1NNU0NaQ0NITEw2c2EzM2ZpM2xkdTJ4?=
 =?utf-8?B?UGhmb2EybW1iSU8zOFNZMjI0Zi9OYzRucDA2Y09mS0VVUTlYN0VDNmxBQk11?=
 =?utf-8?B?SWxFSFVSTEFZUnFRc3l4QzdlZ040WFAyUVhCNWNHUDhGRlA3Q2lPVytDa0di?=
 =?utf-8?B?dVRmTXIwVFVxWTYrU2dWMkd4VjdhbUpPRi9yQkEwRS93SmRHUUdZaHpldm5w?=
 =?utf-8?B?aUFwL1B2NXMydlE0MkRPRDFCSGQ5ampHcGtmS2xpdG9hSUtoQjM0VENWdTNk?=
 =?utf-8?B?WjZwa2c0V09RR3JCWHN2eEdCeTFGbUtxbktSTnNPVUNRc3g5Vko1YUVUN2FY?=
 =?utf-8?B?UzRHMGtQMS9ScVlsb21FNnNwaVpkanpvMGR4c1E0b2hEWFM5WDRRUk5lRmI2?=
 =?utf-8?B?QUZaQmJEdnJqRVhwWDNmSWRWazNHTFpvWlhaallSTkhsWXVEaXBNYUVuOXA2?=
 =?utf-8?B?dVgyWjdMWG13WExoR1pqN0FpZVE0aEJLbDhHdTBmaW81NHErc0JETSt3U09n?=
 =?utf-8?B?QTRLUm1hL0RRNG4zazNaUkpSSTdEeVdZMnNodnZMSklUcVNJMyt5RjBCcElZ?=
 =?utf-8?B?aGhCZzVZSEVRSjJMbXArWFA4Q2dqUEd5SXJMbEU1akxjaUZrWGZyQStmOHEr?=
 =?utf-8?B?YWtlRnhMWUNnV1BlcGxIa0RZd2dkb1BDYVI5TTBNYjBPRVdpNFFHaDJuQlJF?=
 =?utf-8?B?MzVodnlScFYvc0Rna29NbFNwZE9oeE1DWk1wUjhhWFo2c0Eyb0YxNEJNc1VR?=
 =?utf-8?B?MUNIYWRMelpiNG80V1k4MWxsVCtCcG9kR3lMY21ZUDhLNFgwTVpQbDZ1aW05?=
 =?utf-8?B?WTRyWG9CaWNxSk5HTzRtQUF5Q1VPbjh0akRvZ2t2aGtwSGd2bnppUFp3TmZq?=
 =?utf-8?B?VS84a01TNzdUbktDMDREL092UURJR3FBVUZNSjZIczBmVXE4eitkTWxoSUhN?=
 =?utf-8?B?Qm9aNWhWNlR6U3JXMHUzQzBkNnVtbHVYRlZxaWpBOTllMFJNa3BhQW01MFZV?=
 =?utf-8?B?ZWU2bnl2ZE92d3pGaTByUVNDVStMc1h2QzRQSmwwMEs4NjNHSHFqRDlSUUxT?=
 =?utf-8?B?YTRnclpZSlZxMlI3Nk1kc01JYmtVdjF1ZCtwOTB4SG5ibUZmVlBhRGpacFds?=
 =?utf-8?B?M0N4cko4ODFNNWV1bWhKZTFzbVRvRU5PV1FsQWp4dmxUZ3dYQTZ2VExJN2to?=
 =?utf-8?B?OVBVcDhHMk5udUU2UWM2ZkI0eTIzaTdDZHpHUzFyNmdlSkRBQ1pYUDFOUUFZ?=
 =?utf-8?B?WUI4eDB5aUtVYmxPeFJpWWh3RlRqY0FSdGdTYWJxbEhidm5HeHBEVFlaQ2F5?=
 =?utf-8?B?RTUraHlScjViSGZURjRBbVFoZTlzTDNRT1g5MWN5RUNncXVTaTBVaWM1TXox?=
 =?utf-8?B?VlhJK1BUQW90K3UvR2duZUR4Y3NTNVJSQUlHVTUxcm1LQ3lOWTVrQ2lYZGdx?=
 =?utf-8?B?bEdiYzg0cjVoZGlWeXA5TmdjKzhHUmhkNVNka2xCK2RvSU1BMVVvT0h5VFhD?=
 =?utf-8?B?UUIyYTF5SnlUaDJsQ2lTaHM1M0sxNnVUbnkxUGhpdUxGTEZoNGcxYVljOFlO?=
 =?utf-8?B?ZCt2bmxWQnJpaFN4bW1vVWJiQlg1UmNncUs5Tzd3bE1lY0x0YWtlRFFnR2k5?=
 =?utf-8?B?cUdtcm90dTZ4WWJ0WWkreXRSY1FiQWpiZ2NXMm5JQnF0d1E5cm5PbmdjdDhz?=
 =?utf-8?B?QW4rQXRDSXhUcVRFcEd1NzlrN09EME9oVXVGS1JBNnhRVUdCb2hzdkdXbzlv?=
 =?utf-8?B?VEd3Wk1SUHYyV2ovMkZoc3ZRUjBURHBFcXF6V0xFT2RtSXlYaTUxR01KQ3pa?=
 =?utf-8?Q?1dNw1oZqEectpqAsM/QVWfR/4=3D?=
X-Microsoft-Antispam-Message-Info: g9PddwQAgW29VPCIj3lg9rbkrPSbCQUeqTb91wkv0/TR10LXt7+03dQmAT03qGeJTfK7n1ksbnLPZGcthJdo/qvSDBDzDZcyI3Ih/iju+5OmSgLaKG1NdM9/ZH4nG/OxlR1B0deSsvhnyTGDEvr6yTKjH4MI5PK2C2OSNUZw+lTeuLoLTO1Bvv6NmnjD2wmz
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3201;6:wpq8kZa3H9jSwlrALfl6vyrXho63AIdHgaj86vQV2w7jC2uhofTk3ZtgB1HLQs7tMlzkw0aPbZnei+E7DJZiLit+PTZOWJzYf+osByUY7Mh7tII6jebP20FGjMsO1ElXyFaPYwchJx7Acs2NiPW++yPLgGDRLCQ1zbqm2WnHN/tjxoUqFa0PxE+0rSO2wSP6yCm/1at/xQPriu+BoowNp0LH/7cvIwjuVsJ/IeQb1xEekJM1dkdmeotTmKNnLuNGYyx5/HVmwUe0bHOGL9YCEZu28HuSSw3RoAks+nBp462L1RCYG9TXgqYXCm4mD95M1mPpAnzX5JaPNoqi07ehkgtd/NYG3wm6lCvmsPX2JkwFafpWs9Cw9QGE78BRuRhgjYhWYyIpfP/IBX4sQReTBxwirba1wUGqVV9RTCIbv4a/GqPzf4cLIqbHCsRo2uPzdbqpcCYZShdYZR/rTsp9TQ==;5:PmTTxrOm07mYhAs7JYif37uhyvM3mq1scDrqiWw9nsuBImyorL992Kq4Usod+PwM6umQM1dDLmspbwjFoIK6ZT8utQksAEowp03wVonap3CKlu59H6XEDEeE741WVkmQ+/vvskKuF8zGJgm6IkeEr1IuPBlto5HnMs60XCSbDpQ=;24:GZBHuW34weq3CbtIJpI8YXs3v9SxnzNFGhkdwXjDTHqj7KwY7QmwxzwfDj4o0xl4ngKqeuxP76Aw5VwEtzDLONrh1zKU4Doq6alMUFSemLw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3201;7:RxKCZ6fds5nz2/iy1cX04hTlROMOC0qq2NTERlRk5w8YylnxSSXmcz3fyi7GqCPZ1hVhYFkTVytpYyela95r2KIu0ueZvKlNhRY9ybx+j1OeDwPby5mnoAHhpm4q90PBRUj2tjewqm9OoTtNVmfHDKjToYaZvjib2xkyT7+djwFGH+FHiJ285eK7Is815/roA7kS8OZ9SdRk2mBIVHmxMt2tck9LJFuB2rBpBurGe/zsk85M21ACSqVOpogTm3iL
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 06:43:12.7137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9606565d-3f34-4455-58ee-08d5d0f8efb1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0302MB3201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 09:40 AM, Juergen Gross wrote:
> On 13/06/18 08:13, Oleksandr Andrushchenko wrote:
>> On 06/13/2018 09:11 AM, Dmitry Torokhov wrote:
>>> On June 12, 2018 10:49:31 PM PDT, Oleksandr Andrushchenko
>>> <andr2000@gmail.com> wrote:
>>>> On 06/13/2018 02:40 AM, Dmitry Torokhov wrote:
>>>>> On Tue, Jun 12, 2018 at 03:46:10PM +0200, Juergen Gross wrote:
>>>>>> On 12/06/18 09:48, Oleksandr Andrushchenko wrote:
>>>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>>>>
>>>>>>> This is the sync up with the canonical definitions of the input,
>>>>>>> sound and display protocols in Xen.
>>>>>>>
>>>>>>> Changes to kbdif:
>>>>>>> 1. Add missing string constants for {feature|request}-raw-pointer
>>>>>>>       to align with the rest of the interface file.
>>>>>>>
>>>>>>> 2. Add new XenStore feature fields, so it is possible to
>>>> individually
>>>>>>>       control set of exposed virtual devices for each guest OS:
>>>>>>>         - set feature-disable-keyboard to 1 if no keyboard device
>>>> needs
>>>>>>>           to be created
>>>>>>>         - set feature-disable-pointer to 1 if no pointer device needs
>>>>>>>           to be created
>>>>>>>
>>>>>>> 3. Move multi-touch device parameters to backend nodes: these are
>>>>>>>        described as a part of frontend's XenBus configuration nodes
>>>>>>>        while they belong to backend's configuration. Fix this by
>>>> moving
>>>>>>>        the parameters to the proper section.
>>>>>>>
>>>>>>> Unique-id field:
>>>>>>> 1. Add unique-id XenBus entry for virtual input and display.
>>>>>>>
>>>>>>> 2. Change type of unique-id field to string for sndif to align with
>>>>>>> display and input protocols.
>>>>>>>
>>>>>>> Signed-off-by: Oleksandr Andrushchenko
>>>> <oleksandr_andrushchenko@epam.com>
>>>>>>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>>>> Reviewed-by: Juergen Gross <jgross@suse.com>
>>>>>>
>>>>>> I'm fine with this patch being added via the input tree with the
>>>> other
>>>>>> patches. In case I should take it via the Xen tree, please send me a
>>>>>> note.
>>>>> Juergen,
>>>>>
>>>>> I created an immutable branch off v4.17 with these 3 patches in case
>>>> you
>>>>> would want to merge them into your tree without waiting for them to
>>>>> appear in mainline:
>>>>>
>>>>> git pull git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
>>>> ib/4.17-xen-kbdfront-runtime-config
>>>>> Thanks.
>>>>>
>>>> Thank you,
>>>> I would prefer the fastest path of course
>>> It will be part of 4.19 pull request; the immutable branch is for
>>> Juergen if he does not want to wait till 4.19 merge window to get the
>>> changes.
>> Ah, I see. Juergen, can we please merge this via Xen tree then which
>> I assume will be faster?
> As Dmitry has it already queued in the input tree I think this is fine.
> I trust him to take the right decision for which kernel version those
> patches are to be queued. They belong to the input tree after all.
Of course, no doubt here
>
> Juergen
>
Thank you,
Oleksandr
