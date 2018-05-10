Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966032AbeEJOaF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:30:05 -0400
Received: from mail-bn3nam01on0054.outbound.protection.outlook.com ([104.47.33.54]:10016
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965664AbeEJOaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:30:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
To: Stephen Bates <sbates@raithlin.com>,
        Jerome Glisse <jglisse@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
 <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
 <1775CC56-4651-422F-953A-18E024D3717C@raithlin.com>
 <20180509160722.GB4140@redhat.com>
 <366A8132-B88A-40F7-BDE3-DA542E45FC0C@raithlin.com>
 <20180509174952.GC4140@redhat.com>
 <405531AE-8315-4A4F-9B0C-8DBE49BFCAB4@raithlin.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <73b6a454-bf84-1640-0b5e-137d03c0ad8c@amd.com>
Date: Thu, 10 May 2018 16:29:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <405531AE-8315-4A4F-9B0C-8DBE49BFCAB4@raithlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM5PR0402CA0002.eurprd04.prod.outlook.com
 (2603:10a6:203:90::12) To CY4PR12MB1718.namprd12.prod.outlook.com
 (2603:10b6:903:121::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1718;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;3:5sUvqCvYpfKOxt5jrsd7ts77hrYw8N0CK2c7VomOJlOaVXlnVwjfaBKUkmpGmxDUa9K2hL+t+P12/GhdhWvQYNAXYYBhNHJ2B0++Ju7Z8Y12rj85fvooCSCFYigNh6gAK6OYJDG8uMG0Cw3OkWCXqUHPAczyAPscfO5DD/PzGHpcpwwiZIRN4ZFUn05UN7jCn1DihJswzY2Bl2ysfmrNNxvJ3TQiy7XqPJVbkQKeqOOdl+KTWZeW8hIXCep7mbnT;25:cmhnkSwLkZwg5bk3t7xEspZB+aEyIXC3AQBEDxXlqjnrCWa5+mwa0PQzpxlvAqyI+MZrEa76y6FbBtRLZeNlYEO4yVDhhYUmdZRw3amyVv9vhOUTFMSs2f8NLtvCwfnl/RRn1axUaYVSCrGNR4YOgdncgpRKouxcIfyAk1/I0zj6u4V3BchBdVEM6EsghCuFXZWWit3Qra0vA2Epwy7C0JdsnVdlyx0E9rkt6blh0Crkp/2bEaZ/5RX42OvXR60AOsBec8drdRpgGvkt6rr7FLsvmkEzRaETfUoQk7iizJBnK8S+GqTHjtXc/JS9GD9zpRBEwYf+Ma7WlYBVTioQcw==;31:b3kpyvsXGV9SFYWBsdj7ikg9xrjazzDGrjjXd2NP8k1LEdqlRCVoOT8twPXOJfmjKMAYMxdbZPysd53s2tHmdM5Ayf8nRUylLJ/1R3wrWJDXxmUkkmizRmDMqXToAVOj6PSxRhU4C0Pel68bO/EcvfpDAJj7GFrDSXJZuXlaoO5giIZSO8e1I1Fmxq5AuL2HIM8t4gNiBRxw8CSAF/VB62T+MLN0a5eN41+Tm/tns8A=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1718:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;20:TYVYuIf6oN7ncQPiLo4YX/Jk4aHoLeKY06QyVAKKy82io1J/vJdqOIl3ee5Cu3hRBRUTV+/ZHW3ew9Jqt/bKhdBP+OgPV0v/VwSyp3US5mBP40Z9TgkcZOJX9bQLcIofAeelD3p0u99PqoBIvDVGkjn0T01N+8xTuu1wBxR2IYiIiBcMsgz646PHhhIofflUcCc3vKjCWVNFqQgD5HExZxaINuvoZEi6QB8Odru6Ld4p0UBJ5rE8HGlwMgEL++yZuq2tprwbH31sbFogSx4ZZ24TvytuH5Q1bmegTg5+5CS3sr7IpmljsQU4fWCK+epytbCGTjeYSgcl9qwH9FRxTO1HM9uAsMMY+yb8uSVMByrJSP9I1RMk6/PQlBkL7nUmWLIjpu9q+zIMoELmYYiBk7/KLWKvnMe9ct1Digmk0qP3Yj2hD7P1IXvKykBA+JVNg50ByKC122qkbLMNJPi8wRvuWUPLckFbp/q9PWI5rwfMvupqQ6M/81EL8eDlMUKz;4:UOaddDjyH9SNNIwT0UFLxbgAx5EGMhc3VEQIq2faWtdBhqIeAAyqcqpJ/Rn2ukXiTHNMZmgTUO2WtlOGtouRHL7FOeLY3MmLk069aMM/MlAcCRy82fXtvwixXfRtp98C8hcNnTku1mlBE7tmNb4nYFWBocuhXMrHs9V3REebYa1Cm3Pwu/1shRYge5k7S7aOME8by3lDPwRX2YIRWLhlCOtPD10S9oI2Revavpt9UXXm28+AeeTuM8LbNKgrs4xSzHvLWMvKfNDMhZgvbUCUaOly5qubwS/pj/LIucHX38fMipfgmByBwBqqa04X11IC
X-Microsoft-Antispam-PRVS: <CY4PR12MB1718544EA25F4DA0A0A22F7F83980@CY4PR12MB1718.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR12MB1718;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1718;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(39380400002)(366004)(199004)(189003)(69234005)(16526019)(97736004)(186003)(46003)(6246003)(64126003)(31686004)(93886005)(8936002)(81156014)(81166006)(53936002)(23676004)(2486003)(305945005)(105586002)(551934003)(52116002)(52146003)(52396003)(7736002)(76176011)(386003)(106356001)(8676002)(54906003)(58126008)(110136005)(4326008)(316002)(7416002)(5660300001)(229853002)(25786009)(6666003)(65826007)(6116002)(1706002)(67846002)(230700001)(6486002)(50466002)(486006)(2906002)(476003)(31696002)(72206003)(86362001)(47776003)(11346002)(36756003)(446003)(2616005)(478600001)(65956001)(68736007)(65806001)(581084001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1718;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNzE4OzIzOmVpTEgrSFByNlBYK2lOcE5BS0d5QTBHVHRs?=
 =?utf-8?B?T1VqRnJhK0RWUGt0aGFXN3Z5UW5JL3RYeHhMbDRsc29tc2RxWklUbjNHbmxV?=
 =?utf-8?B?MVRtN3FCUEpXQjczMDBUUkc4SE13N2E1MUl2aGVJT3VNS2hzRWs5MldCMVNv?=
 =?utf-8?B?NjNMVXdxdVJ1dHNPTkt4UUlUQ25CaG5XMVFYNnZDN1NQcVJjeTQ3QlNNakdF?=
 =?utf-8?B?T3F1bWx2MU1Mc1VqVmMrZ0huNG9EcmVaWldZRXA3eVliOTU2V1YxVzJrNWdE?=
 =?utf-8?B?Y29yKzNsS2N3Z3lEQUY5a2l1Zm9iMGFwOHZSMlIzdE5GWHFLYmQwaVZGTEhN?=
 =?utf-8?B?ZnB3YzhOdzVUY2ZRRi9vL1FreDR4cWs3aW1ZY2hmNkJxeVRkRzZ6d082Qmxm?=
 =?utf-8?B?a0drbXZ0bm4vVHRKdTJQYlV4dktHUTJOZmVlUUh1RWM5NkkwYWduOTlKNXVj?=
 =?utf-8?B?OFV2a3I5TkM5MXhTeEFyeURQUXY0N2tjVEdtdWFwSWc3WERjaHNZaWh5YmM5?=
 =?utf-8?B?Yk12bE1JQTRLSzloS2VTcSsyQmp0N294ZE5Ld1JwdWdNWlR1NUFNb28xSHoy?=
 =?utf-8?B?RUErUzhkL2JLenk0cTBMVjczTjNLempCYm94aW5PZEUydWdOTkhoc3B1eDc0?=
 =?utf-8?B?TFZMeU5yMTlKaUQ3M3UyNHRXWk42dzRRckY1a0M3akh2bnR3aldvakk0VzE2?=
 =?utf-8?B?OERtd2oyTGN5WFJ4Q3cvRGN6V04weDBZODB4NERQRUQrQnpOdngyVStCTjNW?=
 =?utf-8?B?aWs1RXRQUWRwdCtiWWdaK3IrR3hPTzBLNUJZeW5hS1ZtVkJCSWFEL2FiYWQz?=
 =?utf-8?B?QUR0Ulg3akVOQkNwMmM1TUNZNFFtNWppMTBVSjlnVnBEcnVPK1BqSGlzR09m?=
 =?utf-8?B?MHZhd3k1WnI5OUZpeGFrVjlLMUFBUng0YmMvb0N3ekhsczNSOTZUaVZ4amRH?=
 =?utf-8?B?ZmVLeUJRRDJZN3dvRk1IMjNoVFVSU3RBdHdmaXAzZDZOcEtXOEdBK2dSNkdB?=
 =?utf-8?B?RzR0VlZyVlIyVERDS3JNMXJFRm4rN3lKNzQzVWVWdkU3aUpIbDdPdng1V3U0?=
 =?utf-8?B?TkRUM1pXcGkzWGllK0g4c21RQ2tLNDJWQ3BNakh5Y1JPT3JPd3l2M2hwbjk3?=
 =?utf-8?B?MjNLT01iL1JBYkhCQnZuaUZYU29VLytEU2hENjkzSldVdFFVMW1CMklRdEFi?=
 =?utf-8?B?ZmVOOENucFFDbmVKWThRa2pNamFCVnI4ZU5Rd3JSN2VscU1qZnNCcnJoTVJJ?=
 =?utf-8?B?T2lLaDFrM1crL2U3U2dJN25DNDZBM2NrMUFzeTNQU2ZxeStGTWhscVhXa3hF?=
 =?utf-8?B?cDV1SFQ0NTk5bjBDYnlmRkh5c1phcGpqQlJ0R0hCZURqQUFWd0N6dG1EVm1Z?=
 =?utf-8?B?M2pySXIxSk5TUkovU0cwQmV3WFdVdzAwSWNRTG1jekdtMnc0UzgxZHFzUEhU?=
 =?utf-8?B?YlJTTzFtcW13M0krZEVFTlo3ZHZxeGI0dkRKRkludzR1bGlkSk95Y0U1S2VR?=
 =?utf-8?B?TmFiS01XVnRxZTFUT2hhRm4vRXJLOFFTV0pZVTk4MjAxSUxHTlZ4eFpISi96?=
 =?utf-8?B?RWJzdXNDV3k1QlMzRXA4RGFOTlZhZ0ZsV0laY0tuZ1NHNk5HMGN6clN0MGsz?=
 =?utf-8?B?S2UvWWJEQnE4SzJQeVFBNDFuL080RSt5U05FY2l1eVBJRzdoODhlNUJzcjR3?=
 =?utf-8?B?RVcrTktSaG9kQ3VGaXR6QTdqblVub3ErUXA3NmZCZmltdCtJRHlIbHZoZlAr?=
 =?utf-8?B?NTZGMUpyUExlV25RU0JObFRKeFhURlVxZlVJa1hkaXkzSDlYaWkxSnpxUW1y?=
 =?utf-8?B?ZEo3R0NwTTQxTjVPcE5nK213T1ZodktkdWFQbVhNb1duZDBPUEc3T1lNQUFx?=
 =?utf-8?B?SXZOWkRWVjMvN1V5b0ppc2d6Y2xqdVVxUEhITmlFemtZU0Z6dUdUZkdDUXNo?=
 =?utf-8?B?Smd1QXd0SlBqdW4xd1F2N0g3TElMWW1UQzBMUGU2WGU1TEpBZE1GTk0yZzZW?=
 =?utf-8?B?T2gvOXR3SG51K3dYWXJBVWg1YnZXd2RxTXQrdz09?=
X-Microsoft-Antispam-Message-Info: F9Ly08t8Hb7ELWqQVNTfkeBJEaL+fa2BFR4iWjTWc5ztCbcQce8UNRNJu8iuo+vTAY75WIIarPiDCPVklNXJ0xVHCEObFf+DbqoAEurgz9eHzfBmmgiJNGD35wF+cu9OPxi4E8S3lXH2GQF5O/pm7O1LCxsV9u5r/Q9OxlGN76Vl4v86tPQpomrSlFlmWTG7
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;6:yzw61wMRBaOtTCEXVPPjP3t0uBhba9NLb7G8AQo2DF5PySqyTWVryDJmbQaxKaIZYVg3ABVjXHyTTF0xKTpPLGb8fy2JqY5TxiG594e0QrHx0fyaPw4aDzfgMVDlHkP82ajU7J+HxcGnzAoySPJq4cSIIpoQFSld4ecjW124Hi4UQCHDjuk58Ywhw68u+CnOwjzTtQtabL91OCffY4hYqLmZEHKTeOMGNq6E7DfaB3vWyvB+VF/lxlG2StLgflMYLMqWcPb7pVi9/LaVvNcvHNXyVc0aWny6u3l2L5pp9ghMLkswSiA+CQs1VnF9YeBTYrQbkFchALKqsUvn3YpXXE/j13aPW3bU20dqNrPoQT+Etgs8qjgDq8/cVhOsZzJD54OuXfTiPqiVxVb/EID+SW9X+BpC+4A2ebBrOJV3VwtlM0IDl45LxsPg2MJUHXwFGYrcmvB2do5AH6x1WBumgg==;5:47ZKanqXkNHj+4gVBGTMdJ6OIYFWeCw9tpJ1/HIioXp5jYsMTvDIHSHdRlkEqgeV8lpaNbulFkONTC/mkEjd4en8kFAuwJIYsYMNF2bmUTvKmcHRkTIKwJyWVK0W/g6VOlHEi0vU6rqf8pWlP9IyPz3VLcuTye84vW5RPR0d76I=;24:9nM8Br8aXgvU+RlrVY+DCLrBt5VPLkX7xJR8gYbtJqi2EOgoILoat9LK5wN9CK5ynF95Y7dZ0Szv3esh0AQOJP4N9Mh/oEVaW+AO8n26lHU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;7:UxP3WWDcNgDukRnZcFjzKBKUIgyieluS03KR3JJKxgb4NYDwA+P0+RGDamv0VdJwVxnSQ+wrslnsvu+bW4zZSo9g0r3VnhHXweEGXCtUjmpgQUwYvCkbp0jxklpVCLa1bER39Vlv78aCPAZCJmpQ0ifEF1YGJo/xDFFOpw7/RLfpOppEbBiO/HI8nJVHHVRDBKK5yjmi+wuldgTDmjKPa/AYD/zZGYqdDD3GNSxvxfMt+uExzjENnsRYiOttj4En;20:K83C3a0rv2A9d/W6AzL3OJIfRI4PbZTdHVa1k50wKGPtmjgijPOE0GKpM6A9Iz3RYfuimU2NYY40ajcdcff0o6MuTG9z+4eQ0M8obtWsu7mcNM7T6n6zpoUXmqC89y5Kjp3YK81KqjmP5AhvSWNJlHXT2Kx2JVbfhVkt2yfFME23IO6AyCn0RDfaftVEbEmpjNxR+SX0v2hq4MY1JgwBiCUJ2b9UoZt7+AWpo8TPrrXL9w2pQH89UYSEzr4OMii1
X-MS-Office365-Filtering-Correlation-Id: ae42ab76-b617-4b52-9bd9-08d5b68281f7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 14:29:55.1379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae42ab76-b617-4b52-9bd9-08d5b68281f7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1718
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10.05.2018 um 16:20 schrieb Stephen Bates:
> Hi Jerome
>
>> As it is tie to PASID this is done using IOMMU so looks for caller
>> of amd_iommu_bind_pasid() or intel_svm_bind_mm() in GPU the existing
>>   user is the AMD GPU driver see:
>      
> Ah thanks. This cleared things up for me. A quick search shows there are still no users of intel_svm_bind_mm() but I see the AMD version used in that GPU driver.

Just FYI: There is also another effort ongoing to give both the AMD, 
Intel as well as ARM IOMMUs a common interface so that drivers can use 
whatever the platform offers fro SVM support.

> One thing I could not grok from the code how the GPU driver indicates which DMA events require ATS translations and which do not. I am assuming the driver implements someway of indicating that and its not just a global ON or OFF for all DMAs? The reason I ask is that I looking at if NVMe was to support ATS what would need to be added in the NVMe spec above and beyond what we have in PCI ATS to support efficient use of ATS (for example would we need a flag in the submission queue entries to indicate a particular IO's SGL/PRP should undergo ATS).

Oh, well that is complicated at best.

On very old hardware it wasn't a window, but instead you had to use 
special commands in your shader which indicated that you want to use an 
ATS transaction instead of a normal PCIe transaction for your 
read/write/atomic.

As Jerome explained on most hardware we have a window inside the 
internal GPU address space which when accessed issues a ATS transaction 
with a configurable PASID.

But on very newer hardware that window became a bit in the GPUVM page 
tables, so in theory we now can control it on a 4K granularity basis for 
the internal 48bit GPU address space.

Christian.

>
> Cheers
>
> Stephen
>
